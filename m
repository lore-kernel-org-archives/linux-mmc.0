From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: restore ocr and operation voltage in resume
Date: Thu, 4 Apr 2013 17:37:11 +0200
Message-ID: <CAPDyKFp8LEd7qb+afJbvUZFSNuDVL3SXshnEH5cuhSgH8L+drA@mail.gmail.com>
References: <1361352662-12263-1-git-send-email-kliu5@marvell.com>
	<loom.20130404T113956-355@post.gmane.org>
	<CAPDyKFrmH85XdqogaztEsbdaSwuXGJrQihocTkckdZ48A5-=zQ@mail.gmail.com>
	<loom.20130404T123942-185@post.gmane.org>
	<CAPDyKFrmo3s=sHn-jx-=bDjH81SDyWUfVGvnnRz6KTpzjO9zwA@mail.gmail.com>
	<loom.20130404T141613-473@post.gmane.org>
	<loom.20130404T164129-208@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f54.google.com ([209.85.212.54]:56311 "EHLO
	mail-vb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760014Ab3DDPhM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Apr 2013 11:37:12 -0400
Received: by mail-vb0-f54.google.com with SMTP id w16so1393700vbf.41
        for <linux-mmc@vger.kernel.org>; Thu, 04 Apr 2013 08:37:11 -0700 (PDT)
In-Reply-To: <loom.20130404T164129-208@post.gmane.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Prasanna NAVARATNA <prasanna.navaratna@gmail.com>
Cc: linux-mmc@vger.kernel.org

On 4 April 2013 16:43, Prasanna NAVARATNA <prasanna.navaratna@gmail.com> wrote:
> Prasanna NAVARATNA <prasanna.navaratna <at> gmail.com> writes:
>
>>
>> So you agree the ocr mask must not be reset during suspend.
>>
>> The patch over here exactly addresses the problem which you stated :-
>> "mmc core should tell the host driver to use the properly negotiated ocr
>> mask to set the voltage level, both at initialization and at resume"
>>
>> The patch saves the ocr which is properly negotiated during initialization
>> time and then restores it back during resume.
>>
>> Will you please elaborate, what is wrong with this patch? Or are you
> trying
>> to tell, this is not the proper way to do the same?

"host->ocr" is intended for keeping the negotiated ocr mask. Another
variable is not needed.

A proper patch would in principle remove the workaround, which means
the reset of the "host->ocr" in mmc_power_off is not done any more.

Exactly what you need to make this work, is as stated before a bit
more complicated.

>>
>> Thanks & Regards,
>> Prasanna NAVARATNA
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo <at> vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>
> Hello,
>
> I have suggested another patch which does the same thing in better way.
> Please refer to the new post "mmc: core: negotiate ocr during resume"
>
> Regards,
> Prasanna NAVARATNA
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
