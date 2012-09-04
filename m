From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
Subject: Re: [PATCH] mmc: sh-mmcif: avoid Oops on spurious interrupts
Date: Tue, 04 Sep 2012 16:40:29 +0900
Message-ID: <5045B06D.6080407@kmckk.co.jp>
References: <878vdxd3mq.wl%kuninori.morimoto.gx@renesas.com> <20120803050039.GA1614@linux-sh.org> <20120809042844.GF1614@linux-sh.org> <87hasc3bv5.wl%kuninori.morimoto.gx@renesas.com> <874nobqntv.wl%kuninori.morimoto.gx@renesas.com> <20120810123804.GK1614@linux-sh.org> <502DDC97.5080501@kmckk.co.jp> <87wr0us6tg.wl%kuninori.morimoto.gx@renesas.com> <20120820031352.GC25767@linux-sh.org> <87obm6ry98.wl%kuninori.morimoto.gx@renesas.com> <20120820043853.GD25767@linux-sh.org> <87mx1qrx1x.wl%kuninori.morimoto.gx@renesas.com> <5031D9FF.8060801@kmckk.co.jp> <Pine.LNX.4.64.1208220840400.26767@axis700.grange> <5034CD80.70501@kmckk.co.jp> <Pine.LNX.4.64.1208230908550.22797@axis700.grange>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050906000808070308080109"
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1208230908550.22797@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, koba@kmckk.co.jp
List-Id: linux-mmc@vger.kernel.org

This is a multi-part message in MIME format.
--------------050906000808070308080109
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello Guennadi,

(2012/08/23 16:11), Guennadi Liakhovetski wrote:> Hello Kobayashi-san
 >
 > On Wed, 22 Aug 2012, Tetsuyuki Kobayashi wrote:
 >
 >> Hello Guennadi,
 >>
 >> Thank you for your patch. I will test this next week.
 >
 > Great, thanks very much! I'l also try to fund some time early in 
September
 > to test on my board. Could you please send me your .config kernel
 > configuration (off-list)?

I attached my .config file for kzm9g board.

My working source tree is:

git clone git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git
checkout kzm9g branch

apply these 3 patches:

[PATCH] ARM: mach-shmobile: Add compilation support for dtbs using 'make 
dtbs'
http://www.spinics.net/lists/linux-sh/msg12970.html

Paul's irqdomain patch
http://www.spinics.net/lists/linux-sh/msg12760.html

[PATCH] ARM: shmobile: sh73a0: fixup RELOC_BASE of intca_irq_pins_desc
http://www.spinics.net/lists/linux-sh/msg12876.html

and then, apply your patch for sh_mmcif.c

Simon's Booting DT kernel on a non-DT bootloader is helpful, too.
http://www.spinics.net/lists/linux-sh/msg13051.html

I made 1 partition of eMMC by fdisk command and made ext4 file system on it.
The spurious interrupts occurs at boot time and when accesses file sytem
on eMMC.


>> (2012/08/22 15:49), Guennadi Liakhovetski wrote:
>>> On some systems, e.g., kzm9g, MMCIF interfaces can produce spurious
>>> interrupts without any active request. To prevent the Oops, that results
>>> in such cases, don't dereference the mmc request pointer until we make
>>> sure, that we are indeed processing such a request.
>>>
>>> Reported-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
>>> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>>> ---
>>>
>>> Hello Kobayashi-san
>>>
>>> On Mon, 20 Aug 2012, Tetsuyuki Kobayashi wrote:
>>>
>>> ...
>>>
>>>> After applying this patch on kzm9g board, I got this error regarding eMMC.
>>>> I think this is another problem.
>>>>
>>>>
>>>> Unable to handle kernel NULL pointer dereference at virtual address
>>>> 00000008
>>>> pgd = c0004000
>>>> [00000008] *pgd=00000000
>>>> Internal error: Oops: 17 [#1] PREEMPT SMP ARM
>>>> Modules linked in:
>>>> CPU: 1    Not tainted  (3.6.0-rc2+ #103)
>>>> PC is at sh_mmcif_irqt+0x20/0xb30
>>>> LR is at irq_thread+0x94/0x16c
>>>
>>> [snip]
>>>
>>>> My quick fix is below.
>>>>
>>>> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
>>>> index 5d81427..e587fbc 100644
>>>> --- a/drivers/mmc/host/sh_mmcif.c
>>>> +++ b/drivers/mmc/host/sh_mmcif.c
>>>> @@ -1104,7 +1104,15 @@ static irqreturn_t sh_mmcif_irqt(int irq, void
>>>> *dev_id)
>>>>    {
>>>>           struct sh_mmcif_host *host = dev_id;
>>>>           struct mmc_request *mrq = host->mrq;
>>>> -       struct mmc_data *data = mrq->data;
>>>> +       /*struct mmc_data *data = mrq->data; -- this cause null pointer
>>>> access*/
>>>> +       struct mmc_data *data;
>>>> +
>>>> +       /* quick fix by koba */
>>>> +       if (mrq == NULL) {
>>>> +               printk("sh_mmcif_irqt: mrq == NULL: host->wait_for=%d\n",
>>>> host->wait_for);
>>>> +       } else {
>>>> +               data = mrq->data;
>>>> +       }
>>>>
>>>>           cancel_delayed_work_sync(&host->timeout_work);
>>>>
>>>>
>>>> With this patch, there is no null pointer accesses and got this log.
>>>>
>>>> sh_mmcif_irqt: mrq == NULL: host->wait_for=0
>>>> sh_mmcif_irqt: mrq == NULL: host->wait_for=0
>>>>     ...
>>>>
>>>> host->wait_for is 0. it is MMCIF_WAIT_FOR_REQUEST.
>>>> There is code such like:
>>>>
>>>>          host->wait_for = MMCIF_WAIT_FOR_REQUEST;
>>>>          host->mrq = NULL;
>>>>
>>>> So, at the top of sh_mmcif_irqt, if host->wait_for ==
>>>> MMCIF_WAIT_FOR_REQUEST,
>>>> host->mrq = NULL.
>>>> It is too earlier to access mrq->data before checking host->mrq. it may
>>>> cause null pointer access.
>>>>
>>>> Goda-san, could you check this and refine the code of sh_mmcif_irqt?
>>>
>>> Thanks for your report and a fix. Could you please double-check, whether
>>> the below patch also fixes your problem? Since such spurious interrupts
>>> are possible I would commit a check like this one, but in the longer run
>>> we want to identify and eliminate them, if possible. But since so far
>>> these interrupts only happen on 1 board model and also not on all units
>>> and not upon each boot, this could be a bit tricky.
>>>
>>> One more question - is this only needed for 3.7 or also for 3.6 / stable?
>>>
>>> Thanks
>>> Guennadi
>>>
>>>    drivers/mmc/host/sh_mmcif.c |    4 ++--
>>>    1 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
>>> index 5d81427..82bf921 100644
>>> --- a/drivers/mmc/host/sh_mmcif.c
>>> +++ b/drivers/mmc/host/sh_mmcif.c
>>> @@ -1104,7 +1104,6 @@ static irqreturn_t sh_mmcif_irqt(int irq, void
>>> *dev_id)
>>>    {
>>>    	struct sh_mmcif_host *host = dev_id;
>>>    	struct mmc_request *mrq = host->mrq;
>>> -	struct mmc_data *data = mrq->data;
>>>
>>>    	cancel_delayed_work_sync(&host->timeout_work);
>>>
>>> @@ -1152,13 +1151,14 @@ static irqreturn_t sh_mmcif_irqt(int irq, void
>>> *dev_id)
>>>    	case MMCIF_WAIT_FOR_READ_END:
>>>    	case MMCIF_WAIT_FOR_WRITE_END:
>>>    		if (host->sd_error)
>>> -			data->error = sh_mmcif_error_manage(host);
>>> +			mrq->data->error = sh_mmcif_error_manage(host);
>>>    		break;
>>>    	default:
>>>    		BUG();
>>>    	}
>>>
>>>    	if (host->wait_for != MMCIF_WAIT_FOR_STOP) {
>>> +		struct mmc_data *data = mrq->data;
>>>    		if (!mrq->cmd->error && data && !data->error)
>>>    			data->bytes_xfered =
>>>    				data->blocks * data->blksz;
>>>



--------------050906000808070308080109
Content-Type: text/plain; charset=Shift_JIS;
 name="kzm9g_koba_defconfig"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="kzm9g_koba_defconfig"

# CONFIG_ARM_PATCH_PHYS_VIRT is not set
CONFIG_EXPERIMENTAL=y
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_SYSVIPC=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=16
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
# CONFIG_IPC_NS is not set
# CONFIG_PID_NS is not set
# CONFIG_NET_NS is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL_SYSCALL=y
CONFIG_EMBEDDED=y
CONFIG_SLAB=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_BLK_DEV_BSG is not set
# CONFIG_IOSCHED_DEADLINE is not set
# CONFIG_IOSCHED_CFQ is not set
CONFIG_ARCH_SHMOBILE=y
CONFIG_KEYBOARD_GPIO_POLLED=y
CONFIG_ARCH_SH73A0=y
CONFIG_MACH_KZM9G=y
CONFIG_MEMORY_START=0x41000000
CONFIG_MEMORY_SIZE=0x1f000000
CONFIG_PL310_ERRATA_588369=y
CONFIG_PL310_ERRATA_727915=y
CONFIG_ARM_ERRATA_743622=y
CONFIG_ARM_ERRATA_751472=y
CONFIG_ARM_ERRATA_754322=y
CONFIG_ARM_ERRATA_754327=y
CONFIG_ARM_ERRATA_764369=y
CONFIG_PL310_ERRATA_769419=y
CONFIG_SMP=y
CONFIG_SCHED_MC=y
CONFIG_PREEMPT=y
CONFIG_AEABI=y
# CONFIG_OABI_COMPAT is not set
CONFIG_HIGHMEM=y
CONFIG_ZBOOT_ROM_TEXT=0x0
CONFIG_ZBOOT_ROM_BSS=0x0
CONFIG_ARM_APPENDED_DTB=y
CONFIG_CMDLINE="console=tty0 console=ttySC4,115200 root=/dev/mmcblk0p2 rootfstype=ext4 rw ip=dhcp ignore_loglevel earlyprintk=sh-sci.4,115200"
CONFIG_CMDLINE_FORCE=y
CONFIG_KEXEC=y
CONFIG_VFP=y
CONFIG_NEON=y
# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
CONFIG_PM_RUNTIME=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
# CONFIG_INET_XFRM_MODE_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_BEET is not set
# CONFIG_INET_LRO is not set
# CONFIG_INET_DIAG is not set
# CONFIG_IPV6 is not set
CONFIG_IRDA=y
CONFIG_SH_IRDA=y
# CONFIG_WIRELESS is not set
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_NETDEVICES=y
CONFIG_SMSC911X=y
# CONFIG_WLAN is not set
CONFIG_INPUT_SPARSEKMAP=y
# CONFIG_INPUT_MOUSEDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_KEYBOARD_ATKBD is not set
# CONFIG_INPUT_MOUSE is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_ST1232=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_SH_SCI=y
CONFIG_SERIAL_SH_SCI_NR_UARTS=9
CONFIG_SERIAL_SH_SCI_CONSOLE=y
# CONFIG_HW_RANDOM is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_SH_MOBILE=y
CONFIG_GPIO_PCF857X=y
# CONFIG_HWMON is not set
CONFIG_FB=y
CONFIG_FB_SH_MOBILE_LCDC=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_LOGO=y
CONFIG_FB_SH_MOBILE_MERAM=y
CONFIG_SOUND=y
CONFIG_SND=y
# CONFIG_SND_SUPPORT_OLD_API is not set
# CONFIG_SND_VERBOSE_PROCFS is not set
# CONFIG_SND_DRIVERS is not set
# CONFIG_SND_ARM is not set
# CONFIG_SND_USB is not set
CONFIG_SND_SOC=y
CONFIG_SND_SOC_SH4_FSI=y
CONFIG_USB=y
CONFIG_USB_R8A66597_HCD=y
CONFIG_USB_RENESAS_USBHS=y
CONFIG_USB_STORAGE=y
CONFIG_USB_GADGET=y
CONFIG_USB_RENESAS_USBHS_UDC=y
CONFIG_USB_ETH=m
CONFIG_USB_MASS_STORAGE=m
CONFIG_MMC=y
# CONFIG_MMC_BLOCK_BOUNCE is not set
CONFIG_MMC_SDHI=y
CONFIG_MMC_SH_MMCIF=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_DRV_RS5C372=y
CONFIG_DMADEVICES=y
CONFIG_SH_DMAE=y
CONFIG_ASYNC_TX_DMA=y
CONFIG_STAGING=y
CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_EXT4_FS=y
CONFIG_VFAT_FS=y
CONFIG_TMPFS=y
# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NFS_FS=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=y
CONFIG_NFS_V4_1=y
CONFIG_ROOT_NFS=y
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_PRINTK_TIME=y
# CONFIG_ENABLE_WARN_DEPRECATED is not set
# CONFIG_ENABLE_MUST_CHECK is not set
# CONFIG_SCHED_DEBUG is not set
# CONFIG_DEBUG_PREEMPT is not set
# CONFIG_DEBUG_BUGVERBOSE is not set
CONFIG_DEBUG_INFO=y
# CONFIG_FTRACE is not set
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_DES=y

--------------050906000808070308080109--
