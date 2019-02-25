From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 1/8] mmc: sdhci: Get rid of finish_tasklet
Date: Mon, 25 Feb 2019 10:17:55 +0200
Message-ID: <abcc1506-cd38-5ff4-aaeb-57e9a9622e90@intel.com>
References: <20190215192033.24203-1-faiz_abbas@ti.com>
 <20190215192033.24203-2-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190215192033.24203-2-faiz_abbas@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, kishon@ti.com, zhang.chunyan@linaro.org
List-Id: linux-mmc@vger.kernel.org

On 15/02/19 9:20 PM, Faiz Abbas wrote:
> sdhci.c has two bottom halves implemented. A threaded_irq for handling
> card insert/remove operations and a tasklet for finishing mmc requests.
> With the addition of external dma support, dmaengine APIs need to
> terminate in non-atomic context before unmapping the dma buffers.
> 
> To facilitate this, remove the finish_tasklet and move the call of
> sdhci_request_done() to the threaded_irq() callback.

The irq thread has a higher latency than the tasklet.  The performance drop
is measurable on the system I tried:

Before:

# dd if=/dev/mmcblk1 of=/dev/null bs=1G count=1 &
1+0 records in
1+0 records out
1073741824 bytes (1.1 GB) copied, 4.44502 s, 242 MB/s

After:

# dd if=/dev/mmcblk1 of=/dev/null bs=1G count=1 &
1+0 records in
1+0 records out
1073741824 bytes (1.1 GB) copied, 4.50898 s, 238 MB/s

So we only want to resort to the thread for the error case.
