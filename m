From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v12 1/6] ARM: sunxi: Add driver for SD/MMC
 hosts found on Allwinner sunxi SoCs
Date: Mon, 12 May 2014 13:34:46 +0200
Message-ID: <CAPDyKFqTT17L23iiF2oXj+bmJruT8_qQBecXbR9iCUKo++KDgQ@mail.gmail.com>
References: <1399794417-9291-1-git-send-email-hdegoede@redhat.com>
	<1399794417-9291-2-git-send-email-hdegoede@redhat.com>
	<CAPDyKFrYeBdB20qhmkcUf5ykw=SbBo6VUPXd=By9dNOvTnvFww@mail.gmail.com>
	<5370AE98.9050808@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDF57NG2XIHRBV7DYKNQKGQERWQXEVY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <5370AE98.9050808-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, =?UTF-8?Q?David_Lanzend=C3=B6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 12 May 2014 13:20, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> Hi,
>
> On 05/12/2014 11:15 AM, Ulf Hansson wrote:
>> On 11 May 2014 09:46, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>> From: David Lanzend=C3=B6rfer <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
>>>
>>> The Allwinner sunxi mmc host uses dma in bus-master mode using a built-=
in
>>> designware idmac controller, which is identical to the one found in the=
 mmc-dw
>>> hosts. However the rest of the host is not identical to mmc-dw, it deal=
s with
>>> sending stop commands in hardware which makes it significantly differen=
t
>>> from the mmc-dw devices.
>>>
>>> HdG: Various cleanups and fixes.
>>>
>>> Signed-off-by: David Lanzend=C3=B6rfer <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
>>> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>>
>> [snip]
>>
>>> +
>>> +static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
>>> +                                 struct mmc_ios *ios)
>>> +{
>>> +       u32 rate, oclk_dly, rval, sclk_dly, src_clk;
>>> +       struct clk_hw *hw =3D __clk_get_hw(host->clk_mmc);
>>
>> Hi Hans,
>>
>> This seems like the wrong approach. But I guess it's related to the
>> "clock phase control" API you have been discussing with the clk
>> maintainer, Mike Turquette!?
>
> Yes, this is meant as a temporary solution until we get a proper
> "clock phase control" API.
>
>>
>> __clk_get_hw is supposed to be used by clk providers, not clk consumers.
>>
>>> +       int ret;
>>> +
>>> +       rate =3D clk_round_rate(host->clk_mmc, ios->clock);
>>> +       dev_dbg(mmc_dev(host->mmc), "setting clk to %d, rounded %d\n",
>>> +               ios->clock, rate);
>>> +
>>> +       /* setting clock rate */
>>> +       ret =3D clk_set_rate(host->clk_mmc, rate);
>>> +       if (ret) {
>>> +               dev_err(mmc_dev(host->mmc), "error setting clk to %d: %=
d\n",
>>> +                       rate, ret);
>>> +               return ret;
>>> +       }
>>> +
>>> +       ret =3D sunxi_mmc_oclk_onoff(host, 0);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       /* clear internal divider */
>>> +       rval =3D mmc_readl(host, REG_CLKCR);
>>> +       rval &=3D ~0xff;
>>> +       mmc_writel(host, REG_CLKCR, rval);
>>> +
>>> +       /* determine delays */
>>> +       if (rate <=3D 400000) {
>>> +               oclk_dly =3D 0;
>>> +               sclk_dly =3D 7;
>>> +       } else if (rate <=3D 25000000) {
>>> +               oclk_dly =3D 0;
>>> +               sclk_dly =3D 5;
>>> +       } else if (rate <=3D 50000000) {
>>> +               if (ios->timing =3D=3D MMC_TIMING_UHS_DDR50) {
>>> +                       oclk_dly =3D 2;
>>> +                       sclk_dly =3D 4;
>>> +               } else {
>>> +                       oclk_dly =3D 3;
>>> +                       sclk_dly =3D 5;
>>> +               }
>>> +       } else {
>>> +               /* rate > 50000000 */
>>> +               oclk_dly =3D 2;
>>> +               sclk_dly =3D 4;
>>> +       }
>>> +
>>> +       src_clk =3D clk_get_rate(clk_get_parent(host->clk_mmc));
>>> +       if (src_clk >=3D 300000000 && src_clk <=3D 400000000) {
>>> +               if (oclk_dly)
>>> +                       oclk_dly--;
>>> +               if (sclk_dly)
>>> +                       sclk_dly--;
>>> +       }
>>> +
>>> +       clk_sunxi_mmc_phase_control(hw, sclk_dly, oclk_dly);
>>> +
>>> +       return sunxi_mmc_oclk_onoff(host, 1);
>>> +}
>>> +
>>
>> [snip]
>>
>> Besides the above, I think this looks good!
>
> Thanks!
>
> Since Mike Turquette has already merged clk_sunxi_mmc_phase_control
> I would like to keep this as is, as I already promised Mike, I can
> safely promise you too: I promise clean this up as soon as the
> "clock phase control" API has been worked out.

Thanks for promise. :-)

Anyway, I think I would like Mike to confirm this violation is
accepted as a temporary solution. Additionally I would like it to be
commented in the code here, that it's a temporary solution and that it
violates the clk API.

Kind regards
Ulf Hansson

>
> Regards,
>
> Hans

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
