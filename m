From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2 01/16] FS: Added demand paging markers to filesystem
Date: Wed, 9 May 2012 10:33:48 +1000
Message-ID: <20120509003348.GM5091@dastard>
References: <1336054995-22988-1-git-send-email-svenkatr@ti.com>
 <1336054995-22988-2-git-send-email-svenkatr@ti.com>
 <20120506233117.GU5091@dastard>
 <CANfBPZ_2JeWUu7ti97CVc=ODeEi65ke9EKV6Uje0JHcCM8gYqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <CANfBPZ_2JeWUu7ti97CVc=ODeEi65ke9EKV6Uje0JHcCM8gYqQ@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, arnd.bergmann@linaro.org, alex.lemberg@sandisk.com, ilan.smith@sandisk.com, lporzio@micron.com, rmk+kernel@arm.linux.org.uk
List-Id: linux-mmc@vger.kernel.org

On Mon, May 07, 2012 at 10:16:30PM +0530, S, Venkatraman wrote:
> Mon, May 7, 2012 at 5:01 AM, Dave Chinner <david@fromorbit.com> wrote:
> > On Thu, May 03, 2012 at 07:53:00PM +0530, Venkatraman S wrote:
> >> From: Ilan Smith <ilan.smith@sandisk.com>
> >>
> >> Add attribute to identify demand paging requests.
> >> Mark readpages with demand paging attribute.
> >>
> >> Signed-off-by: Ilan Smith <ilan.smith@sandisk.com>
> >> Signed-off-by: Alex Lemberg <alex.lemberg@sandisk.com>
> >> Signed-off-by: Venkatraman S <svenkatr@ti.com>
> >> ---
> >> =A0fs/mpage.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 ++
> >> =A0include/linux/bio.h =A0 =A0 =A0 | =A0 =A07 +++++++
> >> =A0include/linux/blk_types.h | =A0 =A02 ++
> >> =A03 files changed, 11 insertions(+)
> >>
> >> diff --git a/fs/mpage.c b/fs/mpage.c
> >> index 0face1c..8b144f5 100644
> >> --- a/fs/mpage.c
> >> +++ b/fs/mpage.c
> >> @@ -386,6 +386,8 @@ mpage_readpages(struct address_space *mapping, s=
truct list_head *pages,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 &last_block_in_bio, &map_bh,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 &first_logical_block,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 get_block);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (bio)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bio->bi_rw=
 |=3D REQ_RW_DMPG;
> >
> > Have you thought about the potential for DOSing a machine
> > with this? That is, user data reads can now preempt writes of any
> > kind, effectively stalling writeback and memory reclaim which will
> > lead to OOM situations. Or, alternatively, journal flushing will get
> > stalled and no new modifications can take place until the read
> > stream stops.
>=20
> This feature doesn't fiddle with the I/O scheduler's ability to balance
> read vs write requests or handling requests from various process queues=
 (CFQ).

And for schedulers like no-op that don't do any read/write balancing?
Also, I thought the code was queuing such demand paged requests at
the front of the queues, too, so bypassing most of the read/write
balancing logic of the elevators...

> Also, for block devices which don't implement the ability to preempt (a=
nd even
> for older versions of MMC devices which don't implement this feature),
> the behaviour
> falls back to waiting for write requests to complete before issuing the=
 read.

Sure, but my point is that you are adding a flag that will be set
for all user data read IO, and then making it priviledged in the
lower layers.

> In low end flash devices, some requests might take too long than normal
> due to background device maintenance (i.e flash erase / reclaim procedu=
re)
> kicking in in the context of an ongoing write, stalling them by several
> orders of magnitude.

And thereby stalling what might be writes critical to operation.
Indeed, how does this affect the system when it starts swapping
heavily? If you keep stalling writes, the system won't be able to
swap and free memory...

> This implementation (See 14/16) does have several checks and
> timers to see that it's not triggered very often.  In my tests,
> where I usually have a generous preemption time window, the abort
> happens < 0.1% of the time.

Yes, but seeing as the user has direct control of the pre-emption
vector, it's not hard to imagine someone using it for a timing
attack...

> > This really seems like functionality that belongs in an IO
> > scheduler so that write starvation can be avoided, not in high-level
> > data read paths where we have no clue about anything else going on
> > in the IO subsystem....
>=20
> Indeed, the feature is built mostly in the low level device driver and
> minor changes in the elevator. Changes above the block layer are only
> about setting
> attributes and transparent to their operation.

The problem is that the attribute you are setting covers every
single data read that is done by all users. If that's what you want
to have happen, then why do you even need a new flag at this layer?
Just treat every non-REQ_META read request as a demand paged IO and
you've got exactly the same behaviour without needing to tag at the
higher layer....

Cheers,

Dave.
--=20
Dave Chinner
david@fromorbit.com

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom internet charges in Canada: sign http://stopthemeter=
.ca/
Don't email: <a href=3Dmailto:"dont@kvack.org"> email@kvack.org </a>
