From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-iproc: suppress spurious interrupt with
 Multiblock read
Date: Mon, 22 May 2017 18:20:34 +0200
Message-ID: <CAPDyKFp3AD-q3d4xj-7GyRBG045t0-NPS0o__JP3AnyqsZqVwg@mail.gmail.com>
References: <1495126660-25044-1-git-send-email-srinath.mannam@broadcom.com>
 <58554ec9-1544-318a-e912-3c5f6ee40e90@intel.com> <CABe79T5hKmn49cKEy-KdMQ-S5HMFuhextddV=D_YY+6_QwEPUQ@mail.gmail.com>
 <CAPDyKFrDZXHqrb-GcXrgvCMaUAhpOXDd-OdPyRw1Qq54cSxZDg@mail.gmail.com> <CABe79T4_r0Was5AwFgrnkbazxe4txe9bU73L+rFJTZCC5o=u3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174]:36099 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbdEVQUf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 May 2017 12:20:35 -0400
Received: by mail-qt0-f174.google.com with SMTP id f55so105790095qta.3
        for <linux-mmc@vger.kernel.org>; Mon, 22 May 2017 09:20:35 -0700 (PDT)
In-Reply-To: <CABe79T4_r0Was5AwFgrnkbazxe4txe9bU73L+rFJTZCC5o=u3g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Srinath Mannam <srinath.mannam@broadcom.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 22 May 2017 at 15:33, Srinath Mannam <srinath.mannam@broadcom.com> wrote:
> On Mon, May 22, 2017 at 5:31 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 22 May 2017 at 13:52, Srinath Mannam <srinath.mannam@broadcom.com> wrote:
>>> On Fri, May 19, 2017 at 11:55 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>> On 18/05/17 19:57, Srinath Mannam wrote:
>>>>> The stingray SDHCI hardware supports ACMD12 and automatically
>>>>> issues after multi block transfer completed.
>>>>>
>>>>> If ACMD12 in SDHCI is disabled, spurious tx done interrupts are seen
>>>>> on multi block read command with below error message:
>>>>>
>>>>> Got data interrupt 0x00000002 even though no data
>>>>> operation was in progress.
>>>>>
>>>>> This patch uses SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 to enable
>>>>> ACM12 support in SDHCI hardware and suppress spurious interrupt.
>>>>>
>>>>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>>>>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>>>>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>>>>
>>>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>>>
>>> Thanks Adrian...
>>>
>>> Will it be possible to take this for Linux-4.12??
>>
>> It's queued for 4.13, however are you saying it's a regression for
>> 4.12? Then what commit fixes it?
>>
>> Perhaps you even want this to go stable?
>>
>> Kind regards
>> Uffe
>
> Yes, this is regression for 4.12.
> Fixes: b580c52d58d9 ("mmc: sdhci-iproc: add IPROC SDHCI driver")
> Yes we want this to go in stable.
>

Alright, applied for fixes and added a stable tag.

Kind regards
Uffe
