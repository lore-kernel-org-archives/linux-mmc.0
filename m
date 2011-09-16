From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: confusion regarding the CMD19 and CMD21 in eMMC/SD card spec
Date: Fri, 16 Sep 2011 11:00:12 +0530
Message-ID: <CAGxe1ZGNBPcCMZQDdxCbO_CBBAm5FcF8R7FV0_P8MLEOcXqwYg@mail.gmail.com>
References: <CAGxe1ZH=mrAdfVR7Uw8mYNAD43BAbW7VGuhA1pN9hbSjTG9HVA@mail.gmail.com>
	<0356427A-B949-4DA6-9F5D-FE0DD54AEDFF@marvell.com>
	<CAGxe1ZG4QjwB5OfrxupG_C+DtQ7sTQ4_EURaF-QrqPPSA3A0jw@mail.gmail.com>
	<20110916044706.GA4030@lovegaga>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61755 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100Ab1IPFaO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Sep 2011 01:30:14 -0400
In-Reply-To: <20110916044706.GA4030@lovegaga>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>
Cc: Philip Rakity <prakity@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hello Aaron Lu,
                    please check the mmc 4.5 specification CMD21 is
tuning command.

regards
Girish K S

On 16 September 2011 10:17, Aaron Lu <aaron.lu@amd.com> wrote:
> On Fri, Sep 16, 2011 at 09:41:04AM +0530, Girish K S wrote:
>> but there is only one host controller to handle these commands.
>> the generic sdhci driver has cmd19 hard coded, thats the reason I
>> asked the question.
>> you can also check it in the function sdhci_execute_tuning it is hard coded as
>> cmd.opcode = MMC_SEND_TUNING_BLOCK; where the macro value is 19.
>> So in case of SD card insertion it will send a SEND_TUNING_BLOCK
>> command to the device. but if
>> MMC card is inserted then it will send a BUS_TEST_W command to the device.
>
> sdhci_execute_tuning will only be called if the inserted card is a sd card
> and it is operating at SDR104 or SDR50 mode(UHS-I).
>
> The host's tuning function is called from the mmc_sd_init_uhs_card,
> and for a mmc card, there is no chance of that function being called.
>
> -Aaron
>
>
