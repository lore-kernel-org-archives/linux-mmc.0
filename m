From: Dinh Nguyen <dinguyen@altera.com>
Subject: Re: [PATCHv4] mmc: dw_mmc: Enable the hold reg for certain speed
 modes
Date: Thu, 9 Jan 2014 10:15:59 -0600
Message-ID: <1389284159.13556.25.camel@linux-builds1>
References: <1387213279-22020-1-git-send-email-dinguyen@altera.com>
	 <52B00737.6050701@linaro.org> <52B059A1.1000306@gmail.com>
	 <52B065B2.6010703@linaro.org> <52BB9B21.7010101@samsung.com>
	 <52BC66C1.9070501@gmail.com> <1389140338.26863.2.camel@linux-builds1>
	 <52CC9DC7.8000400@samsung.com> <52CD5CE4.7050108@gmail.com>
	 <52CE1A74.4090005@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db9lp0249.outbound.messaging.microsoft.com ([213.199.154.249]:7774
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751973AbaAIQR6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jan 2014 11:17:58 -0500
In-Reply-To: <52CE1A74.4090005@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Dinh Nguyen <dinh.linux@gmail.com>, zhangfei <zhangfei.gao@linaro.org>, arnd@arndb.de, cjb@laptop.org, tgih.jun@samsung.com, heiko@sntech.de, dianders@chromium.org, alim.akhtar@samsung.com, bzhao@marvell.com, linux-mmc@vger.kernel.org

On Thu, 2014-01-09 at 12:41 +0900, Jaehoon Chung wrote:
> Dear, Dinh
> 
> On 01/08/2014 11:12 PM, Dinh Nguyen wrote:
> > 
> > On 1/7/14 6:37 PM, Jaehoon Chung wrote:
> >> Hi, Dinh.
> >>
> >> Sorry for replying too late.
> >>
> >> ..[snip]..
> >>>>>>>>> +    sdr_timing[1] = ddr_timing[1] = 1;
> >>>>>>>>> +    of_property_read_u32_array(np,
> >>>>>>>>> +            "samsung,dw-mshc-sdr-timing", sdr_timing, 2);
> >>>>>>>>> +
> >>>>>>>>> +    of_property_read_u32_array(np,
> >>>>>>>>> +            "samsung,dw-mshc-ddr-timing", ddr_timing, 2);
> >>>>>>>>> +
> >>>>>>>>> +    pdata->cclk_in_drv = 1;
> >>>>>>>>> +    if ((sdr_timing[1] == 0) || (ddr_timing[1] == 0))
> >>>>>>>>> +        pdata->cclk_in_drv = 0;
> >>>>>>>>> +
> >>>>>>>> Have some concern about whether it is suitable putting "samsung,~"
> >>>>>>>> property in dw_mmc.c, is it supposed to be platform related?
> >>>>>>>> Any conflict with drivers/mmc/host/dw_mmc-exynos.c?
> >>>>>>>> If they are really commonly used, how about change name and define in
> >>>>>>>> Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt?
> >>>>>>> I had submitted a patch to make this a common binding before:
> >>>>>>>
> >>>>>>> http://www.spinics.net/lists/devicetree/msg00638.html
> >>>>>>>
> >>>>>>> I think the ultimate conclusion to that thread was that its perfectly
> >>>>>>> acceptable to re-use bindings from other
> >>>>>>> platforms.
> >>>>>>>
> >>>>>> Hmm, ususally I may look for the properties of dw_mmc.c in synopsys-dw-mshc.txt.
> >>>>>> If this is the conclusion before, then just ignore this noise.
> >>>>> If can be removed the samsung property, then i think property of clock timing can be used into dw-mmc.c
> >>>>> But if samsung property is used, well. I think right that it's used into dw_mmc-exynos.c.
> >>>>> Dw-mmc.c is general driver..so we don't want to include any SoC specific code.
> >>>> Then do you suggest I go forward with an attempt to add a new generic
> >>>> "snps,dw-mshc-sdr-timing"
> >>>> binding?
> >>> Ping Jaehoon?
> >>>
> >>> Do you think I need to add a generic "snps,dw-mshc-sdr-timing" and
> >>> "snps,dw-mshc-ddr-timing" bindings then?
> >> Well, i think it's also something wrong. ddr/sdr-timing is exynos specific value, not synopsys value.
> >> If synopsys use the sdr/ddr timing, then it's right that "snps, dw-mshc-sdr/ddr-timing" is used.
> > I went through the databook and I think that the timing values are
> > mentioned throughout the spec. It
> > just does not explicitly mentions ddr/sdr timing, but it is mentioned as
> > cclk_in_drv(aka drvsel), and
> > cclk_in_sample(aka smpsel). Even the macro in dw_mmc-exynos,
> > SDMMC_CLKSEL_CCLK_DRIVE() and
> > SDMMC_CLKSEL_CCLK_SAMPLE() is stating this.
> > 
> > So I do not believe that "samsung, dw-mshc-sdr-timing" and
> > "samsung,dw-mshc-ddr-timing" are not
> > exclusive to only the exynos platform. Just the fact that the SOCFPGA
> > platform can re-use the same
> > "samsung,dw-mshc-sdr-timing" property proves that this is not just an
> > exynos specific value.
> 
> i didn't see the register that the sdr/ddr timing is used at Synopsys DoC file.
> Even if SOCFPGA platform can reuse the samsung property, it's not general property, isn't?

I think the Rockchip platform can also use it, but it hasn't been
clearly documented yet.

> Under SoC.. cclk_in_drv can be implemented differently.

Yes, agreed. Clearly the cclk_in_drv and cclk_in_sample methods to shift
the phase of the CIU clock is implemented differently. The exynos'
implementation is not getting touched at all.

> We have just known that sdr/ddr timing is used at exynos/socfpga board.
> 
> I just found clk_drv/smpl_phase_ctrl at UHS register, I think this isn't ddr/sdr timing.


But let's take a look at what are the possible values ddr/sdr timings
can take? From Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt:

"Valid values for SDR and DDR CIU clock timing for Exynos5250:
      - valid value for tx phase shift and rx phase shift is 0 to 7."

For socfpga, 0 = 45 degrees shift, 1 = 90 degrees shift,...[n++] and 7 =
315 degrees shift. If my guess is correct, it should also be the same
for exynos.


> 
> >> But i didn't see sdr/ddr timing in synopsys DoC.
> >> I know you want to control the hold-reg bit. 
> >> But this approach is not good.
> > 
> > The spec has a table on when to use the hold-reg bit. The conditions for
> > using the hold-reg bit is
> > only dependent the hold-reg hw implementation and the value of
> > cclk_in_drv. The value of cclk_in_drv
> > is specified by the 2nd parameter of "samsung,dw-mshc-sdr-timing".
> 
> Right, the spec is mentioned when hold-reg bit could be used.
> But that's not that ddr/sdr timing is general value.

Do you agree that the 2nd value of sdr/ddr timing is representing the
cclk_in_drv? Looking at the code dw_mmc-exynos.c, this is indeed what
the 2nd value in sdr/ddr timing is representing.


So we can come up with a more generic DTS binding that the generic
dw_mmc driver can use to set the hold-reg, but that binding still needs
to pass in the cclk_in_drv somehow, as cclk_in_drv is the only external
variable that is needed to determine when to set hold-reg.

And if sdr/ddr timing is already representing cclk_in_drv, doesn't it
make sense to re-use that binding?

Thanks,
Dinh
> 
> Best Regards,
> Jaehoon Chung
> > 
> > So I don't understand why you think this approach is "not good"?
> > 
> > Thanks,
> > Dinh
> >> Rather, how about using the callback function for exynos specific value.
> >> Then other SoC can also use it.
> >>
> >> Best Regards,
> >> Jaehoon Chung
> >>
> >>> Dinh
> >>>> Dinh
> >>>>> If i missed something, then let me know, plz.
> >>>>>
> >>>>> Best Regards,
> >>>>> Jaehoon Chung
> >>>>>> Thanks
> >>>>>>
> >>>>
> >>>
> >>>
> >>>
> > 
> > 
> 
> 



