From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH 2/2] mmc: fix integer assignments to pointer
Date: Wed, 24 Aug 2011 16:53:07 +0530
Message-ID: <CANfBPZ_MfTVDWo8As3c-Ax5bjr=QN2rK2CYdmdY4Qw4cRbok2Q@mail.gmail.com>
References: <1314114363-6767-1-git-send-email-svenkatr@ti.com>
 <1314114363-6767-3-git-send-email-svenkatr@ti.com> <m27h643x8k.fsf@bob.laptop.org>
 <20110823165620.GA9132@merkur.ravnborg.org> <4E542C6E.5080507@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
In-Reply-To: <4E542C6E.5080507@linux.intel.com>
Sender: linux-sparse-owner@vger.kernel.org
To: J Freyensee <james_p_freyensee@linux.intel.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-sparse@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Aug 24, 2011 at 4:10 AM, J Freyensee
<james_p_freyensee@linux.intel.com> wrote:
> On 08/23/2011 09:56 AM, Sam Ravnborg wrote:
>>
>> On Tue, Aug 23, 2011 at 12:31:55PM -0400, Chris Ball wrote:
>>>
>>> Hi,
>>>
>>> [Adding linux-sparse@ to CC]
>>>
>>> On Tue, Aug 23 2011, Venkatraman S wrote:
>>>>
>>>> Fix the sparse warning output
>>>> "warning: Using plain integer as NULL pointer"
>>>>
>>>> Signed-off-by: Venkatraman S<svenkatr@ti.com>
>>>> ---
>>>> =A0drivers/mmc/card/block.c =A0 =A0| =A0 =A04 ++--
>>>> =A0drivers/mmc/core/core.c =A0 =A0 | =A0 =A02 +-
>>>> =A0drivers/mmc/core/mmc_ops.c =A0| =A0 =A04 ++--
>>>> =A0drivers/mmc/core/sdio_ops.c | =A0 =A02 +-
>>>> =A04 files changed, 6 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>>>> index 1ff5486..e702c61 100644
>>>> --- a/drivers/mmc/card/block.c
>>>> +++ b/drivers/mmc/card/block.c
>>>> @@ -291,7 +291,7 @@ static int mmc_blk_ioctl_cmd(struct block_devi=
ce
>>>> *bdev,
>>>> =A0 =A0 =A0 =A0struct mmc_card *card;
>>>> =A0 =A0 =A0 =A0struct mmc_command cmd =3D {0};
>>>> =A0 =A0 =A0 =A0struct mmc_data data =3D {0};
>>>> - =A0 =A0 =A0 struct mmc_request mrq =3D {0};
>>>> + =A0 =A0 =A0 struct mmc_request mrq =3D {NULL};
>>>> =A0 =A0 =A0 =A0struct scatterlist sg;
>>>> =A0 =A0 =A0 =A0int err;
>>>> [...]
>>>
>>> The sparse warning is mistaken. =A0Or I'm mistaken. =A0But I suspec=
t it's
>>> the sparse warning.
>>>
>
> Okay, stupid question times:
>
>>>> - =A0 struct mmc_request mrq =3D {0};
>
> this is 'struct mmc_request mrq' and not 'struct mmc_request *mrq', r=
ight?
>
> Then I think the sparse warning is correct. =A0From my experience, sp=
arse is
> very clear: if any variable is defined as a pointer, you use NULL to =
reset
> the pointer instead of '0', and if any variable is a normal variable,=
 you
> use '0' to reset the variable. I don't think sparse is smart enough t=
o look
> at the underlying variables, which in this case, mrq contains members=
 that
> are pointers to something.
>
> in this case, the defined variable is not a pointer, rather a variabl=
e named
> mrq that is of type 'struct mmc_request'. =A0Therefore, 0 is correct =
to use
> and NULL is incorrect.

Please tolerate my misunderstanding here - but aren't the above two sta=
tements
contradictory ?
My understanding was the '0' or NULL would be assigned to the first mem=
ber of
struct mmc_request, which happens to be a pointer. Hence NULL is more c=
orrect
than '0', right ?

The type of the structure variable is irrelevant here. i.e.
struct mmc_request mrq =3D {0};
and
struct mmc_request *mrq =3D {0};

would generate the same warning, isn't it ?

>
> If you want it to be sparse-correct as well as human-readable correct=
, you
> probably should write the code that explicitly shows assigning each p=
ointer
> member of mrq to NULL, ie:
>
> struct mmc_request mrq;
> mrq.sbc =3D NULL;
> mrq.cmd =3D NULL;
> mrq.data =3D NULL;
> .
> .
> etc.
>
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
