From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v2 1/8] mmc: sdhci: Get rid of finish_tasklet
Date: Wed, 6 Mar 2019 15:30:06 +0530
Message-ID: <8d72ff93-e07f-52b9-da85-acd54f046694@ti.com>
References: <20190215192033.24203-1-faiz_abbas@ti.com>
 <20190215192033.24203-2-faiz_abbas@ti.com>
 <abcc1506-cd38-5ff4-aaeb-57e9a9622e90@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <abcc1506-cd38-5ff4-aaeb-57e9a9622e90@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, kishon@ti.com, zhang.chunyan@linaro.org
List-Id: linux-mmc@vger.kernel.org

Adrian,

On 25/02/19 1:47 PM, Adrian Hunter wrote:
> On 15/02/19 9:20 PM, Faiz Abbas wrote:
>> sdhci.c has two bottom halves implemented. A threaded_irq for handling
>> card insert/remove operations and a tasklet for finishing mmc requests.
>> With the addition of external dma support, dmaengine APIs need to
>> terminate in non-atomic context before unmapping the dma buffers.
>>
>> To facilitate this, remove the finish_tasklet and move the call of
>> sdhci_request_done() to the threaded_irq() callback.
> 
> The irq thread has a higher latency than the tasklet.  The performance drop
> is measurable on the system I tried:
> 
> Before:
> 
> # dd if=/dev/mmcblk1 of=/dev/null bs=1G count=1 &
> 1+0 records in
> 1+0 records out
> 1073741824 bytes (1.1 GB) copied, 4.44502 s, 242 MB/s
> 
> After:
> 
> # dd if=/dev/mmcblk1 of=/dev/null bs=1G count=1 &
> 1+0 records in
> 1+0 records out
> 1073741824 bytes (1.1 GB) copied, 4.50898 s, 238 MB/s
> 
> So we only want to resort to the thread for the error case.
> 

Sorry for the late response here, but this is about 1.6% decrease. I
tried out the same commands on a dra7xx board here (with about 5
consecutive dd of 1GB) and the average decrease was 0.3%. I believe you
will also find a lesser percentage change if you average over multiple
dd commands.

Is this really so significant that we have to maintain two different
bottom halves and keep having difficulty with adding APIs that can sleep?

Also I am not sure how to implement only the error handling part in the
threaded_irq. We need to enter sdhci_request_done() and get the current
mrq before we can check for error conditions like I've done in patch 2:

/* Terminate and synchronize dma in case of an error */
if (data && (mrq->cmd->error || data->error) &&
    host->use_external_dma) {
	struct dma_chan *chan = sdhci_external_dma_channel(host, data);
	dmaengine_terminate_sync(chan);
}

On a related note, do we really need to protect everything in
sdhci_request_done() with spinlocks? In patch 2 I have only removed lock
for the terminate_sync() parts that I added but the whole
dma_unmap/dma_sync parts should be left unprotected IMO.

Thanks,
Faiz
