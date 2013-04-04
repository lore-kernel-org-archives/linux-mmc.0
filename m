From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: restore ocr and operation voltage in resume
Date: Thu, 4 Apr 2013 13:47:26 +0200
Message-ID: <CAPDyKFrmo3s=sHn-jx-=bDjH81SDyWUfVGvnnRz6KTpzjO9zwA@mail.gmail.com>
References: <1361352662-12263-1-git-send-email-kliu5@marvell.com>
	<loom.20130404T113956-355@post.gmane.org>
	<CAPDyKFrmH85XdqogaztEsbdaSwuXGJrQihocTkckdZ48A5-=zQ@mail.gmail.com>
	<loom.20130404T123942-185@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f182.google.com ([209.85.128.182]:36824 "EHLO
	mail-ve0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758922Ab3DDLr1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Apr 2013 07:47:27 -0400
Received: by mail-ve0-f182.google.com with SMTP id m1so2553780ves.27
        for <linux-mmc@vger.kernel.org>; Thu, 04 Apr 2013 04:47:27 -0700 (PDT)
In-Reply-To: <loom.20130404T123942-185@post.gmane.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Prasanna NAVARATNA <prasanna.navaratna@gmail.com>
Cc: linux-mmc@vger.kernel.org

On 4 April 2013 12:43, Prasanna NAVARATNA <prasanna.navaratna@gmail.com> wrote:
> Ulf Hansson <ulf.hansson <at> linaro.org> writes:
>
>>
>> On 4 April 2013 11:44, Prasanna NAVARATNA <prasanna.navaratna <at>
> gmail.com> wrote:
>> > Kevin Liu <kliu5 <at> marvell.com> writes:
>> >
>> >>
>> >> host->ocr has been reset in power off but not restored after power up
>> >> in resume. And operation voltage will be set to the highest after
> resume
>> >> back. This patch fix these two bugs.
>> >>
>> >> Signed-off-by: Kevin Liu <kliu5 <at> marvell.com>
>> >> ---
>> >>  drivers/mmc/core/core.c  |    3 ++-
>> >>  include/linux/mmc/host.h |    1 +
>> >>  2 files changed, 3 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> >> index 08a3cf2..b8c3d41 100644
>> >> --- a/drivers/mmc/core/core.c
>> >> +++ b/drivers/mmc/core/core.c
>> >>  <at>  <at>  -1523,6 +1523,7  <at>  <at>  void mmc_power_off(struct
>> > mmc_host *host)
>> >>        * Reset ocr mask to be the highest possible voltage supported
> for
>> >>        * this mmc host. This value will be used at next power up.
>> >>        */
>> >> +     host->ocr_bak = host->ocr;
>> >>       host->ocr = 1 << (fls(host->ocr_avail) - 1);
>> >>
>> >>       if (!mmc_host_is_spi(host)) {
>> >>  <at>  <at>  -2666,7 +2667,7  <at>  <at>  int mmc_resume_host(struct
>> > mmc_host *host)
>> >>       if (host->bus_ops && !host->bus_dead) {
>> >>               if (!mmc_card_keep_power(host)) {
>> >>                       mmc_power_up(host);
>> >> -                     mmc_select_voltage(host, host->ocr);
>> >> +                     host->ocr = mmc_select_voltage(host, host-
>>ocr_bak);
>> >>                       /*
>> >>                        * Tell runtime PM core we just powered up the
> card,
>> >>                        * since it still believes the card is powered
> off.
>> >> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> >> index d6f20cc..6e355d1 100644
>> >> --- a/include/linux/mmc/host.h
>> >> +++ b/include/linux/mmc/host.h
>> >>  <at>  <at>  -309,6 +309,7  <at>  <at>  struct mmc_host {
>> >>
>> >>       struct mmc_ios          ios;            /* current io bus
> settings
>> > */
>> >>       u32                     ocr;            /* the current OCR
> setting
>> > */
>> >> +     u32                     ocr_bak;        /* save current OCR
> setting
>> > */
>> >>
>> >>       /* group bitfields together to minimize padding */
>> >>       unsigned int            use_spi_crc:1;
>> >
>> >
>> > Hello Kevin,
>> >
>> > Any update on this patch?
>> >
>> > I have seen an issue where during initialization, core will get card's
> ocr
>> > and match with host ocr available and select the appropriate voltage
> (3.0V)
>>
>> You may think this is done correct, but it is not. Host drivers does
>> in general not change voltage in MMC_POWER_ON state, which is what is
>> required if the new negotiated ocr mask shall be used.  According to
>> the mmc/sd spec voltage level changes requires a full power cycle
>> sequence which is not done from the protocol layer, and which is why
>> host drivers also should not consider changing voltages at
>> MMC_POWER_ON state.
>>
>> Note that debugfs is then also not telling the truth about the voltage
>> level being used.
>>
>> > But during suspend, maximum supported voltage from host is saved back
> and
>> > when resuming back requesting for highest voltage of host (3.3V).
>> > It doesn't care about card's OCR.
>>
>> In practice, it is same voltage level that has been used all the time,
>> except for those host driver that do change levels in MMC_POWER_ON
>> mode.
>>
>> Kind regards
>> Ulf Hansson
>>
>> >
>> > This patch fixes it. Looks valid for me.
>> >
>> > Thanks & Regards,
>> > Prasanna NAVARATNA
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> > the body of a message to majordomo <at> vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo <at> vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> I agree host shouldn't change voltages during MMC_POWER_ON state, but if
> core calls set_ios, with different voltage for the regulator, then voltage
> will be changed accordingly.
> Consider this case where I am observing the issue :-
>
> During initialization, (struct mmc_host *host) "host->ocr_avail" is updated
> with, what IP supports. (Maximum up to 3.3V)
>
> mmc core will query the card OCR status :-
> err = mmc_send_app_op_cond(host, 0, &ocr);
> and this ocr is used to select voltage
> host->ocr = mmc_select_voltage(host, ocr);
> In mmc_select_voltage,
> ocr &= host->ocr_avail; // Fair consideration done
> ios.vdd = ffs (ocr) - 1
> So ideally, this will consider card's OCR and what host supports and will
> choose appropriate voltage.
>
> But during suspend, in mmc_power_off, ocr mask is reseted to be the highest
> possible voltage supported for the mmc_host.
> host->ocr = 1 << (fls(host->ocr_avail) - 1);  // which is 3.3V
>
> While resuming back, in mmc_power_up, you'll restore back the highest
> supported voltage for this mmc_host and request to set for that value(using
> set_ios).
> Then mmc_select_voltage is called with highest supported voltage of host and
> not with card's OCR. It discards the card's OCR completely! (it will use
> saved host->ocr during suspend, where max 3.3V is set)
>
> Don't you think, it must consider the card's OCR too during resume as done
> during initialization?
> Please correct, if any of my assumption is wrong.

You are definitely correct, the ocr mask must not be reset during
suspend. But, the next problem is much more complex to solve; mmc core
should tell the host driver to use the properly negotiated ocr mask to
set the voltage level. Both at initialization and at resume. This
patch does not solve anything in this regards.

Kind regards
Ulf Hansson

>
> Thanks & Regards,
> Prasanna NAVARATNA
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
