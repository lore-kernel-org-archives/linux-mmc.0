From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [REGRESSION 4.10] dw_mmc: failures on Rockchip rk3288 veyron
 boards
Date: Thu, 30 Mar 2017 09:32:22 +0800
Message-ID: <6d87cb71-1339-0dc9-e071-1c117f541881@rock-chips.com>
References: <20170330011709.GA110687@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20170330011709.GA110687-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, amstan-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Brian,

On 2017/3/30 9:17, Brian Norris wrote:
> Hi all,
>
> I haven't managed to get as far as a bugfix for this, but I've bisected
> some issues seen on v4.10+ with a Chromebook of the Veyron family (Jaq,
> in particular). v4.9 works fine.

Does your v4.10+ kernel  have these commits?

commit e9748e0364fe82dc037d22900ff13a62d04518bf
Author: Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Date:   Tue Jan 17 09:22:56 2017 +0800

     mmc: dw_mmc: force setup bus if active slots exist


commit df9bcc2bc0a1f8d2963bd916698268fb2470713b
Author: Joonyoung Shim <jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Date:   Fri Nov 25 12:47:15 2016 +0900

     mmc: dw_mmc: add missing codes for runtime resume


commit ce69e2fea093b7fa3991c87849c4955cd47796c9
Author: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Date:   Tue Jan 17 09:22:55 2017 +0800

     mmc: dw_mmc: silent verbose log when calling from PM context


>
> Issue #1 - eMMC complains periodically:
>
> [    4.358135] mmc_host mmc2: Bus speed (slot 0) = 148500000Hz (slot req 150000000Hz, actual 148500000HZ div = 0)
> [    4.461466] mmc_host mmc2: Bus speed (slot 0) = 148500000Hz (slot req 150000000Hz, actual 148500000HZ div = 0)
> [    5.291450] mmc_host mmc2: Bus speed (slot 0) = 148500000Hz (slot req 150000000Hz, actual 148500000HZ div = 0)
> [    5.381471] mmc_host mmc2: Bus speed (slot 0) = 148500000Hz (slot req 150000000Hz, actual 148500000HZ div = 0)
> [   11.243337] mmc_host mmc2: Bus speed (slot 0) = 148500000Hz (slot req 150000000Hz, actual 148500000HZ div = 0)
> [   17.371628] mmc_host mmc2: Bus speed (slot 0) = 148500000Hz (slot req 150000000Hz, actual 148500000HZ div = 0)
>
> and if I stress it out at all (e.g., dd if=/dev/mmcblk2 bs=1M >
> /dev/null), it will eventually croak:
>
> [  359.916315] mmc_host mmc2: Bus speed (slot 0) = 148500000Hz (slot req 150000000Hz, actual 148500000HZ div = 0)
> [  360.071378] dwmmc_rockchip ff0f0000.dwmmc: Successfully tuned phase to 153
> [  360.211351] mmcblk2: error -110 transferring data, sector 8644608, nr 2048, cmd response 0x900, card status 0x0
> [  360.221936] mmcblk2: retrying using single block read
> [  363.491362] mmcblk2: error -110 transferring data, sector 8646656, nr 2048, cmd response 0x900, card status 0x0
> [  363.531569] mmc_host mmc2: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
> [  363.596326] mmc_host mmc2: Bus speed (slot 0) = 148500000Hz (slot req 150000000Hz, actual 148500000HZ div = 0)
> [  363.612712] dwmmc_rockchip ff0f0000.dwmmc: Successfully tuned phase to 152
> [  363.751351] mmcblk2: error -110 transferring data, sector 8646656, nr 2048, cmd response 0x900, card status 0x0
> [  363.761938] mmcblk2: retrying using single block read
> [  366.611356] INFO: task mmcqd/2boot1:92 blocked for more than 120 seconds.
> [  366.618134]       Not tainted 4.10.0 #284
> [  366.622146] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  366.629960] mmcqd/2boot1    D    0    92      2 0x00000000
> [  366.635454] [<c07dc21c>] (__schedule) from [<c07dc4e0>] (schedule+0x90/0xa0)
> [  366.642497] [<c07dc4e0>] (schedule) from [<c066e8b4>] (__mmc_claim_host+0xd4/0x19c)
> [  366.650142] [<c066e8b4>] (__mmc_claim_host) from [<c066e9ac>] (mmc_get_card+0x30/0x34)
> [  366.658056] [<c066e9ac>] (mmc_get_card) from [<c067fc8c>] (mmc_blk_issue_rq+0x64/0x48c)
> [  366.666052] [<c067fc8c>] (mmc_blk_issue_rq) from [<c0680230>] (mmc_queue_thread+0x114/0x1b4)
> [  366.674484] [<c0680230>] (mmc_queue_thread) from [<c023d1b0>] (kthread+0x128/0x144)
> [  366.682134] [<c023d1b0>] (kthread) from [<c02076e8>] (ret_from_fork+0x14/0x2c)
> ...
>
> Issue #2 - Wifi (via SDIO, mmc1) is completely dead:
>
> [    1.444125] mmc_host mmc1: card is non-removable.
> [    1.471368] mmc_host mmc1: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
> [    1.619553] mmc_host mmc1: Bus speed (slot 0) = 148500000Hz (slot req 150000000Hz, actual 148500000HZ div = 0)
> [    1.881699] mmc1: new ultra high speed SDR104 SDIO card at address 0001
> [   25.681172] mmc_host mmc1: Bus speed (slot 0) = 148500000Hz (slot req 150000000Hz, actual 148500000HZ div = 0)
> [   25.691666] mwifiex: rx work enabled, cpus 4
> [   26.827000] mwifiex_sdio mmc1:0001:1: info: FW download over, size 800344 bytes
> [   27.561352] mwifiex_sdio mmc1:0001:1: WLAN FW is active
> [   33.585165] mmc_host mmc1: Bus speed (slot 0) = 148500000Hz (slot req 150000000Hz, actual 148500000HZ div = 0)
> [   37.651344] mwifiex_sdio mmc1:0001:1: mwifiex_cmd_timeout_func: Timeout cmd id = 0xa9, act = 0x0
> [   37.660122] mwifiex_sdio mmc1:0001:1: num_data_h2c_failure = 0
> [   37.665951] mwifiex_sdio mmc1:0001:1: num_cmd_h2c_failure = 0
> [   37.671688] mwifiex_sdio mmc1:0001:1: is_cmd_timedout = 1
> [   37.677076] mwifiex_sdio mmc1:0001:1: num_tx_timeout = 0
> [   37.682380] mwifiex_sdio mmc1:0001:1: last_cmd_index = 1
> [   37.687681] mwifiex_sdio mmc1:0001:1: last_cmd_id: 00 00 a9 00 00 00 00 00 00 00
> [   37.695066] mwifiex_sdio mmc1:0001:1: last_cmd_act: 00 00 00 00 00 00 00 00 00 00
> [   37.702536] mwifiex_sdio mmc1:0001:1: last_cmd_resp_index = 0
> [   37.708269] mwifiex_sdio mmc1:0001:1: last_cmd_resp_id: 00 00 00 00 00 00 00 00 00 00
> [   37.716087] mwifiex_sdio mmc1:0001:1: last_event_index = 0
> [   37.721564] mwifiex_sdio mmc1:0001:1: last_event: 00 00 00 00 00 00 00 00 00 00
> [   37.728857] mwifiex_sdio mmc1:0001:1: data_sent=1 cmd_sent=0
> [   37.734508] mwifiex_sdio mmc1:0001:1: ps_mode=0 ps_state=0
> [   37.740016] mmc_host mmc1: Bus speed (slot 0) = 148500000Hz (slot req 150000000Hz, actual 148500000HZ div = 0)
> [   37.750268] mwifiex_sdio mmc1:0001:1: info: mwifiex_fw_dpc: unregister device
>
> For either of these issues, if I simply revert the dw_mmc driver back to
> its v4.9 version (but keep everything else at v4.10), things seem to
> work fine.
>
> At this point, I'm pretty sure that it's the runtime PM support added to
> dw_mmc that cause the regression.
>
> Any thoughts? I don't exactly plan on trying to debug a solution myself here,
> but I thought I'd report it in case somebody else has ideas.
>
> Brian
>
>
>
