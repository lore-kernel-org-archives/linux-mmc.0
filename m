From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-iproc: suppress spurious interrupt with
 Multiblock read
Date: Mon, 22 May 2017 14:01:02 +0200
Message-ID: <CAPDyKFrDZXHqrb-GcXrgvCMaUAhpOXDd-OdPyRw1Qq54cSxZDg@mail.gmail.com>
References: <1495126660-25044-1-git-send-email-srinath.mannam@broadcom.com>
 <58554ec9-1544-318a-e912-3c5f6ee40e90@intel.com> <CABe79T5hKmn49cKEy-KdMQ-S5HMFuhextddV=D_YY+6_QwEPUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABe79T5hKmn49cKEy-KdMQ-S5HMFuhextddV=D_YY+6_QwEPUQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinath Mannam <srinath.mannam@broadcom.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 22 May 2017 at 13:52, Srinath Mannam <srinath.mannam@broadcom.com> wrote:
> On Fri, May 19, 2017 at 11:55 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 18/05/17 19:57, Srinath Mannam wrote:
>>> The stingray SDHCI hardware supports ACMD12 and automatically
>>> issues after multi block transfer completed.
>>>
>>> If ACMD12 in SDHCI is disabled, spurious tx done interrupts are seen
>>> on multi block read command with below error message:
>>>
>>> Got data interrupt 0x00000002 even though no data
>>> operation was in progress.
>>>
>>> This patch uses SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 to enable
>>> ACM12 support in SDHCI hardware and suppress spurious interrupt.
>>>
>>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>>
>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
> Thanks Adrian...
>
> Will it be possible to take this for Linux-4.12??

It's queued for 4.13, however are you saying it's a regression for
4.12? Then what commit fixes it?

Perhaps you even want this to go stable?

Kind regards
Uffe
