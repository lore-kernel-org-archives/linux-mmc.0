From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: Continuous SD IO causes hung task messages
Date: Tue, 27 Aug 2019 15:55:23 +0200
Message-ID: <CAPDyKFp7e2OD_idam3-2sEd0wJU5OcP=H04G1OvHmAUo2Y-bYw@mail.gmail.com>
References: <20190827134337.GK13294@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190827134337.GK13294@shell.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 27 Aug 2019 at 15:43, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> Hi,
>
> While dd'ing the contents of a SD card, I get hung task timeout
> messages as per below.  However, the dd is making progress.  Any
> ideas?
>
> Presumably, mmc_rescan doesn't get a look-in while IO is progressing
> for the card?

Is it a regression?

There not much of recent mmc core and mmc block changes, that I can
think of at this point.

>
> ARM64 host, Macchiatobin, uSD card.

What mmc host driver is it? mmci?

Kind regards
Uffe

>
> Thanks.
>
> root@arm-d06300000000:~# dd if=/dev/mmcblk1 | md5sum
> INFO: task kworker/2:1:52 blocked for more than 120 seconds.
>       Not tainted 5.2.0+ #309
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> kworker/2:1     D    0    52      2 0x00000028
> Workqueue: events_freezable mmc_rescan
> Call trace:
>  __switch_to+0xb0/0x198
>  __schedule+0x22c/0x604
>  schedule+0x38/0xc8
>  __mmc_claim_host+0xcc/0x1ec
>  mmc_get_card+0x30/0x3c
>  mmc_sd_detect+0x1c/0x78
>  mmc_rescan+0x1c4/0x35c
>  process_one_work+0x14c/0x408
>  worker_thread+0x140/0x3f4
>  kthread+0xfc/0x128
>  ret_from_fork+0x10/0x18
> INFO: task kworker/2:1:52 blocked for more than 120 seconds.
>       Not tainted 5.2.0+ #309
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> kworker/2:1     D    0    52      2 0x00000028
> Workqueue: events_freezable mmc_rescan
> Call trace:
>  __switch_to+0xb0/0x198
>  __schedule+0x22c/0x604
>  schedule+0x38/0xc8
>  __mmc_claim_host+0xcc/0x1ec
>  mmc_get_card+0x30/0x3c
>  mmc_sd_detect+0x1c/0x78
>  mmc_rescan+0x1c4/0x35c
>  process_one_work+0x14c/0x408
>  worker_thread+0x140/0x3f4
>  kthread+0xfc/0x128
>  ret_from_fork+0x10/0x18
> INFO: task kworker/2:1:52 blocked for more than 241 seconds.
>       Not tainted 5.2.0+ #309
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> kworker/2:1     D    0    52      2 0x00000028
> Workqueue: events_freezable mmc_rescan
> Call trace:
>  __switch_to+0xb0/0x198
>  __schedule+0x22c/0x604
>  schedule+0x38/0xc8
>  __mmc_claim_host+0xcc/0x1ec
>  mmc_get_card+0x30/0x3c
>  mmc_sd_detect+0x1c/0x78
>  mmc_rescan+0x1c4/0x35c
>  process_one_work+0x14c/0x408
>  worker_thread+0x140/0x3f4
>  kthread+0xfc/0x128
>  ret_from_fork+0x10/0x18
> INFO: task kworker/2:1:52 blocked for more than 362 seconds.
>       Not tainted 5.2.0+ #309
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> kworker/2:1     D    0    52      2 0x00000028
> Workqueue: events_freezable mmc_rescan
> Call trace:
>  __switch_to+0xb0/0x198
>  __schedule+0x22c/0x604
>  schedule+0x38/0xc8
>  __mmc_claim_host+0xcc/0x1ec
>  mmc_get_card+0x30/0x3c
>  mmc_sd_detect+0x1c/0x78
>  mmc_rescan+0x1c4/0x35c
>  process_one_work+0x14c/0x408
>  worker_thread+0x140/0x3f4
>  kthread+0xfc/0x128
>  ret_from_fork+0x10/0x18
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up
