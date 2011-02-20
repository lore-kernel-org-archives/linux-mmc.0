From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: MMC quirks relating to performance/lifetime.
Date: Sun, 20 Feb 2011 15:39:08 +0100
Message-ID: <201102201539.08496.arnd@arndb.de>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com> <201102171647.46190.arnd@arndb.de> <AANLkTimGrT_p_5xdXJv5UURPMC0cwJCPkZ=xcX5Nk=o=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <AANLkTimGrT_p_5xdXJv5UURPMC0cwJCPkZ=xcX5Nk=o=@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Cc: Andrei Warkentin <andreiw@motorola.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

[adding linux-fsdevel to Cc, see http://lwn.net/Articles/428941/ and
http://comments.gmane.org/gmane.linux.ports.arm.kernel/105607 for more
on this discussion.]

On Sunday 20 February 2011 12:27:39 Andrei Warkentin wrote:
> On Thu, Feb 17, 2011 at 9:47 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > I think I'd try to reduce the number of sysfs files needed for this.
> > What are the values you would typically set here?
> >
> > My feeling is that separating unaligned page writes from full pages
> > or multiples of pages could always be benefitial for all cards, or at
> > least harmless, but that will require more measurements.
> > Whether to do the reliable write or not could be a simple flag
> > if the numbers are the same.
> 
> I thought about this some more, and I realized it would be ugly if
> everybody added enable_workaround_sec_start/enable_workaround_sec_end
> for every novel idea of working around some issue with
> performance/reliability on mmc/sd cards.
> 
> What about letting the user/embedder create policies for how certain
> accesses are done? That way you give runtime-accessible
> blocks for tuning mmc block layer while having one interface to
> manipulate (and combine) multiple workarounds, all the while catching
> conflicts and
> without forcing specific policy in code.
> 
> Essentially under /sys/block/mmcblk0/device you have an attribute
> called "policies". Example:
> 
> # echo mypol0 > /sys/block/mmcblk0/device/policies
> # ls /sys/block/mmcblk0/device/mypol0
> debug
> delete
> start_block
> end_block
> access_size_low
> access_size_high
> write_policy
> erase_policy
> read_policy
> # cat /sys/block/mmcblk0/device/mypol0/write_policy
> Current: none
> 0x00000001: Split unaligned writes across page_size
> 0x00000002: Split writes into page_size chunks and write using reliable writes
> 0x00000004: Use reliable writes for WRITE_META blocks.
> # cat /sys/block/mmcblk0/device/mypol0/erase_policy
> Current: none
> 0x00000001: Use secure erase.
> # echo 1 > delete
> # Policy is deleted.
> 
> The policies are all stored in a rb-tree. First order of business
> inside mmc_blk_issue_rw_rq/mmc_blk_issue_* is to fetch an existing
> policy given the access type and block start/end (which both tells
> where the access is going and the size of the access). Later, it's
> that policy information which controls how the request is translated
> into MMC commands. I'm almost done with a prototype.

I think it's good to discuss all the options, but my feeling is that
we should not add so much complexity at the interface level, because
we will never be able to change all that again. In general, sysfs
files should contain simple values that are self-descriptive (a simple
number or one word), and should have no side-effects (unlike the delete
or the policies attributes you describe).

The behavior of the Toshiba chip is peculiar enough to justify having
some workarounds for it, including run-time selected ones, but I'm
looking for something much simpler. I'd certainly be interested in
the patch you come up with and any performance results, but I don't
think it can be merged like that.

In the end, Chris will have to make the decision on mmc patches of
course -- I'm just trying to contribute experience from other subsystems.

What I see as a more promising approach is to add the tunables
to attributes of the CFQ I/O scheduler once we know what we want.
This will allow doing the same optimizations to non-MMC devices such
as USB sticks or CF/IDE cards without reimplementing it in other
subsystems, and give more control over the individual requests than
the MMC layer has.

E.g. the I/O scheduler can also make sure that we always submit all
blocks from the start of one erase unit (e.g. 4 MB) to the end, but
not try to merge requests across erase unit boundaries. It can
also try to group the requests in aligned power-of-two sized chunks
rather than merging as many sectors as possible up to the maximum
request size, ignoring the alignment.

	Arnd
