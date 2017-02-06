From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2 2/2] mmc: Checking BKOPS status prior to Suspend
Date: Mon, 6 Feb 2017 14:46:38 +0800
Message-ID: <2a786eb3-d782-bb87-4ff5-29640b00ad2f@rock-chips.com>
References: <1485076535-20572-1-git-send-email-uri.yanai@sandisk.com>
 <1485076535-20572-3-git-send-email-uri.yanai@sandisk.com>
 <CAPDyKFqiiWxUaYYkmPX_Zcym2fJ_muYM2WF2erd5LLd_OCY=5A@mail.gmail.com>
 <935e77c5-7e6a-00e0-9064-ea9dbcb4fef5@rock-chips.com>
 <695B0367-2BA5-4B95-AF75-6BD43FE17528@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:50803 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbdBFGqy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Feb 2017 01:46:54 -0500
In-Reply-To: <695B0367-2BA5-4B95-AF75-6BD43FE17528@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Lemberg <Alex.Lemberg@sandisk.com>, Uri Yanai <Uri.Yanai@sandisk.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Harjani Ritesh <riteshh@codeaurora.org>

Hi Alex,

On 2017/2/5 23:13, Alex Lemberg wrote:
> Hi Shawn,
>
> On 2/5/17, 3:43 AM, "Shawn Lin" <shawn.lin@rock-chips.com> wrote:
>
>
>     >
>     > Hmm.
>     >
>     > Shouldn't we abort (return -EBUSY) also in the system PM suspend case
>     > and not only for runtime PM suspend?
>
>     I would rather we don't abort runtime PM, but do it for system PM
>     instead. What we do for runtime PM is just for saving power for
>     our hosts including manipulating clock and genpd etc.. Thus we don't
>     touch any power-supply for eMMC. If so, it could still be possible
>     for eMMC firmware to work on doing bkops in rpm context.
>
> If I understand correctly, you are suggesting do not send SLEEP command
> on Runtime Suspend?

yes.

> If so, and if mmc host does not touch any power supply for eMMC,
> the device can continue doing Auto BKOPS during Runtime Suspend.
> The question is why the Sleep command is sent now,
> in the original implementation?
> I assume it is sent for saving a power from the device side as well?

right, it was invented with the cap of MMC_CAP_AGGRESSIVE_PM, so some 
platforms ask for the aggressive power policy will send sleep command
to the cards in rpm context. So I assume they care power-saving more
than others.


>
> N�����r��y���b�X��ǧv�^�)޺{.n�+����{��g"��^n�r���z���h����&���G���h�(�階�ݢj"���m�����z�ޖ���f���h���~�mml==
>

