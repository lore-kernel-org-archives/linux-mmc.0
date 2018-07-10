From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: improve rationality of bus width setting for HS400es
Date: Tue, 10 Jul 2018 10:14:48 +0200
Message-ID: <CAPDyKFqfwxGgVhKp-RU1Ksd2BKhxvqdqXf0JV3dzyJdgfeBV+w@mail.gmail.com>
References: <1531118843-796-1-git-send-email-hongjiefang@asrmicro.com>
 <CAPDyKFpzJV-UQbMa7_tHms7o3hMn9_g=H_M0jW+ZN9G=8XCqRg@mail.gmail.com> <86aa8215d6e44e578cd34f0625c5ebef@mail2012.asrmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <86aa8215d6e44e578cd34f0625c5ebef@mail2012.asrmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?RmFuZyBIb25namllKOaWuea0quadsCk=?= <hongjiefang@asrmicro.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Linus Walleij <linus.walleij@linaro.org>, Bastian Stender <bst@pengutronix.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Chanho Min <chanho.min@lge.com>, Kyle Roeschley <kyle.roeschley@ni.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 10 July 2018 at 07:04, Fang Hongjie(=E6=96=B9=E6=B4=AA=E6=9D=B0) <hongji=
efang@asrmicro.com> wrote:
>> On 9 July 2018 at 08:47, Hongjie Fang <hongjiefang@asrmicro.com> wrote:
>> > mmc_select_hs400es() calls mmc_select_bus_width() which will try to
>> > set 4bit transfer mode if fail to set 8bit mode. The problem is that
>> > the bus width should not be set to 4bit in HS400es mode.
>>
>> I guess it fails because there is something wrong. Can you please
>> elaborate under what circumstance the problem occurs?
>>
> This problem very occasionally occurred when system resume from
> suspend state. The card stuck in the programming state after setting
> 8bit mode. After that, mmc_select_bus_width() will continue to set
> 4bit mode and return without errors. Of course, the following R/W
> requests will be all failing.

I see. So it's the mmc_switch() operation that fails, when trying 8-bit. Hm=
m.

>
> The problem scene is hard to reproduce. Maybe it happened
> because there is something wrong about bus clock or core voltage
> stability when system do resume.

Yeah, that needs further debugging.

Don't know what host driver you are using, but potentially you could
play with a couple host specific mechanism. The ->host->card_busy()
callback, host->max_busy_timeout and MMC_CAP_WAIT_WHILE_BUSY.
Depending on these, __mmc_switch() changes its policy when polling for
busy. Have a look at __mmc_switch() and mmc_poll_for_busy(), to see
what goes on.

>
>> >
>> > Signed-off-by: Hongjie Fang <hongjiefang@asrmicro.com>
>> > ---
>> >  drivers/mmc/core/mmc.c | 23 +++++++++++++++++++++--
>> >  1 file changed, 21 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> > index 4466f5d..94c3cc5 100644
>> > --- a/drivers/mmc/core/mmc.c
>> > +++ b/drivers/mmc/core/mmc.c
>> > @@ -1337,9 +1337,28 @@ static int mmc_select_hs400es(struct mmc_card *=
card)
>> >         if (err)
>> >                 goto out_err;
>> >
>> > -       err =3D mmc_select_bus_width(card);
>> > -       if (err < 0)
>> > +       /* Switch card to 8 bit mode */
>> > +       err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> > +                        EXT_CSD_BUS_WIDTH,
>> > +                        EXT_CSD_BUS_WIDTH_8,
>> > +                        card->ext_csd.generic_cmd6_time);
>> > +       if (err) {
>> > +               pr_err("%s: switch to 8 bit mode for hs400es failed, e=
rr:%d\n",
>> > +                       mmc_hostname(host), err);
>> > +               goto out_err;
>> > +       }
>> > +
>> > +       mmc_set_bus_width(host, MMC_BUS_WIDTH_8);
>> > +
>> > +       if (!(host->caps & MMC_CAP_BUS_WIDTH_TEST))
>> > +               err =3D mmc_compare_ext_csds(card, MMC_BUS_WIDTH_8);
>> > +       else
>> > +               err =3D mmc_bus_test(card, MMC_BUS_WIDTH_8);
>> > +       if (err) {
>> > +               pr_err("%s: test 8 bit mode for hs400es failed, err:%d=
\n",
>> > +                       mmc_hostname(host), err);
>> >                 goto out_err;
>>
>> Lot's open coding, no I don't like it.
>>
>> Wouldn't it instead be possible to check the return value from
>> mmc_select_bus_width(), as it should tell what width it manage to
>> select. Then if it isn't 8-bit, then we should bail out. Does that
>> work?
>>
> After setting 4bit mode, it can't work because it cannot back to
> HS200 mode like the HS400 mode.
> For HS400es, if fail to set 8bit mode, maybe it is more reasonable
> that return error directly.

Yeah. Care to send a patch for that?

[...]

Kind regards
Uffe
