From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: Issue with Broadcom wireless in 5.2rc1 (was Re: [PATCH] mmc:
 sdhci: queue work after sdhci_defer_done())
Date: Tue, 4 Jun 2019 13:33:18 +0200
Message-ID: <af4d6703-8506-dad7-c2ed-13fa8b2e390d@broadcom.com>
References: <20190524111053.12228-1-masneyb@onstation.org>
 <70782901-a9ac-5647-1abe-89c86a44a01b@intel.com>
 <20190524154958.GB16322@basecamp> <20190526122136.GA26456@basecamp>
 <e8c049ce-07e1-8b34-678d-41b3d6d41983@broadcom.com>
 <20190526195819.GA29665@basecamp> <20190527093711.GA853@basecamp>
 <ead7f268-b730-3541-31f7-4499556efec0@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ead7f268-b730-3541-31f7-4499556efec0@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Brian Masney <masneyb@onstation.org>
Cc: Franky Lin <franky.lin@broadcom.com>, Hante Meuleman <hante.meuleman@broadcom.com>, Chi-Hsien Lin <chi-hsien.lin@cypress.com>, Wright Feng <wright.feng@cypress.com>, ulf.hansson@linaro.org, faiz_abbas@ti.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com, brcm80211-dev-list@cypress.com, netdev@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 5/27/2019 2:08 PM, Adrian Hunter wrote:
> On 27/05/19 12:37 PM, Brian Masney wrote:
>> On Sun, May 26, 2019 at 03:58:19PM -0400, Brian Masney wrote:
>>> I attached a patch that shows how I was able to determine what had
>>> already claimed the host.
>> On Mon, May 27, 2019 at 10:48:24AM +0300, Adrian Hunter wrote:
>>> This is because SDHCI is using the IRQ thread to process the SDIO card
>>> interrupt (sdio_run_irqs()).  When the card driver tries to use the card, it
>>> causes interrupts which deadlocks since c07a48c26519 ("mmc: sdhci: Remove
>>> finish_tasklet") has moved the tasklet processing to the IRQ thread.
>>>
>>> I would expect to be able to use the IRQ thread to complete requests, and it
>>> is desirable to do so because it is lower latency.
>>>
>>> Probably, SDHCI should use sdio_signal_irq() which queues a work item, and
>>> is what other drivers are doing.
>>>
>>> I will investigate some more and send a patch.
> 
> Please try the patch below:

Finally got time to update my kernel to 5.2-rc2. This patch indeed 
resolves the issue.

Thanks,
Arend
