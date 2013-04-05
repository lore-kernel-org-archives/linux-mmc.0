From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: restore ocr and operation voltage in resume
Date: Fri, 5 Apr 2013 11:39:26 +0200
Message-ID: <CAPDyKFpiDOQjpXaZHVQbBj7NAezR=0bmwAmADZ73N6nmSMsF2A@mail.gmail.com>
References: <1361352662-12263-1-git-send-email-kliu5@marvell.com>
	<loom.20130404T113956-355@post.gmane.org>
	<CAPDyKFrmH85XdqogaztEsbdaSwuXGJrQihocTkckdZ48A5-=zQ@mail.gmail.com>
	<loom.20130404T123942-185@post.gmane.org>
	<CAPDyKFrmo3s=sHn-jx-=bDjH81SDyWUfVGvnnRz6KTpzjO9zwA@mail.gmail.com>
	<loom.20130404T141613-473@post.gmane.org>
	<loom.20130404T164129-208@post.gmane.org>
	<CAPDyKFp8LEd7qb+afJbvUZFSNuDVL3SXshnEH5cuhSgH8L+drA@mail.gmail.com>
	<loom.20130405T080017-884@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:57447 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130Ab3DEJj1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Apr 2013 05:39:27 -0400
Received: by mail-vb0-f46.google.com with SMTP id 11so1970381vbe.5
        for <linux-mmc@vger.kernel.org>; Fri, 05 Apr 2013 02:39:26 -0700 (PDT)
In-Reply-To: <loom.20130405T080017-884@post.gmane.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Prasanna NAVARATNA <prasanna.navaratna@gmail.com>
Cc: linux-mmc@vger.kernel.org

On 5 April 2013 08:07, Prasanna NAVARATNA <prasanna.navaratna@gmail.com> wrote:
> Ulf Hansson <ulf.hansson <at> linaro.org> writes:
>
>> "host->ocr" is intended for keeping the negotiated ocr mask. Another
>> variable is not needed.
>>
>> A proper patch would in principle remove the workaround, which means
>> the reset of the "host->ocr" in mmc_power_off is not done any more.
>>
>> Exactly what you need to make this work, is as stated before a bit
>> more complicated.
>
> Hello Ulf,
>
> The work around is introduced by yourself :-
> "At power off, reset OCR mask to be the highest possible voltage
> supported for the current mmc host.
>
> This solves the re-initialization during the power up sequence.
> The voltage may have been decreased due to the card accepts a lower
> voltage than the voltage used during the initialization sequence.
> We need to reset the voltage to by the host highest possible value
> since according to _specification_ the initialization must always be
> done at high voltage"
>
> So do you think, solution to current issue is to revert this patch? This
> will not violate the spec as you are mentioning above?

The solution is not to revert, but to make a proper patch which solves
the initialization issues and the suspend/resume issues.

If you just revert the patch you will break suspend/resume sequence
for a many SoC I believe.

> If you agree, i'll push a new patch by reverting this. Else consider another
> way in my new post "mmc: core: negotiate ocr during resume"
> This patch will follow the spec and will also negotiate ocr during
> mmc_resume_host.
>
> Thanks,
> Prasanna NAVARATNA
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
