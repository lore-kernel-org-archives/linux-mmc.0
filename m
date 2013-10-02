From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Do not poll for busy with status cmd for all
 switch cmds
Date: Wed, 2 Oct 2013 16:08:12 +0200
Message-ID: <CAPDyKFoc1UOgYDD+ssMmrM9koBYN4yniC-n=dLACmSEvioWJtw@mail.gmail.com>
References: <1378893256-27460-1-git-send-email-ulf.hansson@linaro.org>
	<523129F5.8030800@samsung.com>
	<86mwmrbznu.fsf@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f169.google.com ([209.85.220.169]:57819 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753447Ab3JBOIN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Oct 2013 10:08:13 -0400
Received: by mail-vc0-f169.google.com with SMTP id ib11so511953vcb.14
        for <linux-mmc@vger.kernel.org>; Wed, 02 Oct 2013 07:08:12 -0700 (PDT)
In-Reply-To: <86mwmrbznu.fsf@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>

On 2 October 2013 14:55, Chris Ball <cjb@laptop.org> wrote:
> Hi Jaehoon,
>
> On Thu, Sep 12 2013, Jaehoon Chung wrote:
>> I will test with this patch, and share the result.
>> Thanks for posting this patch.
>
> Did you get a chance to test this?  Thanks,
>

Hi Chris,

FYI:

I have tested this on a ux500 board with some out of tree patches to
enable suspend/resume and with MMC_CAP2_FULL_PWR_CYCLE. I could not
find any regression and moreover I think it important that we do not
violate the eMMC spec for power off notify, which is what we did
before.

The background to this patch, comes from a off list discussion between
Jaehoon and me. It seems like Jaehoon encountered some issues with
power off notify. I was hoping this patch might help him.

Kind
Ulf Hansson

> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
