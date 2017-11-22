From: Pintu Kumar <pintu.ping-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [tegra186]: emmc resume failing after booting from snapshot image
Date: Wed, 22 Nov 2017 17:56:08 +0530
Message-ID: <CAOuPNLgW84yuXxm8HLQ7KS-1=0nPo9s7OumWt4ipkm7D2pdmog@mail.gmail.com>
References: <CAOuPNLjWvqvcb+eDp52GsXEfvtzAcTneUxGhQc9bPWYGsqxpEQ@mail.gmail.com>
 <d2b3b1e3-dd08-2aad-c027-2c51e4b72459@kapsi.fi> <b607c51f-559e-0315-6843-c0d9d07cb81e@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <b607c51f-559e-0315-6843-c0d9d07cb81e-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Mikko Perttunen <cyndis-/1wQRMveznE@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Nov 22, 2017 at 4:10 PM, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> Hi Pintu,
>
> I think that the appropriate place to ask about this issue is on the TX2
> forum [0]. Someone should be able to help you there.
>

Hello Jon,
Yes I raised my query there almost 1 week back here.
https://devtalk.nvidia.com/default/topic/1026527/jetson-tx2/-jetson-tx2-mmc-resume-errors-after-booting-from-suspend/

But no response.
So, I thought to discuss it here.
May be some pointers may help to find the root cause.
One point is that, I am able to resume the board with the sd-card, but
resume from emmc is returning -110 (may be CMD5 timeout).
Whether there is any difference between sd-card resume and emmc resume ?
Do we need to check the card initialization sequence for emmc ?


> Cheers
> Jon
>
> [0] https://devtalk.nvidia.com/default/board/188/jetson-tx2/
>
> On 22/11/17 09:11, Mikko Perttunen wrote:
>> The upstream kernel currently has no core rail suspend support (LP0/SC7)
>> on Tegras - in general the downstream kernel (used e.g. in L4T) is the
>> reference that has the most functionality on Tegra.
>>
>> IIRC the MMC subsystem and Tegra MMC driver between upstream and
>> downstream are currently quite diverged so the upstream folks are
>> unlikely to be able to help with issues with the downstream code.
>>
>> Mikko
>>
>> On 22.11.2017 08:41, Pintu Kumar wrote:
>>> Hi,
>>>
>>> I am trying to bring up suspend-to-disk (snapshot boot) on jetson-tx2
>>> board (nvidia tegra186).
>>> Suspend is working fine, but during boot with snapshot image, emmc
>>> resume is failing.
>>> Kernel version: 4.4
>>> Repo: https://nv-tegra.nvidia.com/gitweb/?p=linux-4.4.git;a=summary
>>> repo: tegra-l4t-r27.1
>>>
>>>
>>> It returns with:
>>> mmc0: error -110 during resume (card was removed?)
>>>
>>> Please see the complete logs below.
>>>
>>> I tried to add some prints in mmc driver to check the cause.
>>> It seems that mmc is not responding during resume.
>>> [  137.125314] mmc_sleep: ERROR: mmc_wait_for_cmd, ret: -110
>>> When I check more, I found that CMD5 (Sleep/Awake) is failing to
>>> response.
>>> It is not able to wakeup the mmc from sleep.
>>>
>>> What could be cause of this problem?
>>> Any pointers or suggestions about this issue will be really helpful....
>>>
>>> When I see the linux kernel mainline kernel-4.14 (latest), I could see
>>> that there are some patches in drivers/mmc/core/* which are missing in
>>> jetson tx2 kernel version-4.4.
>>> Do you think any of the latest patches may help to solve this issue?
>>> If yes, can you point to some of relevant once?
>>>
>>>
>>> Please help.
>>>
>>>
>>> Thanks,
>>> Pintu
>>>
>>> LOGS:
>>> -----------------------------------------------------------
>>> ## Booting ...
>>> [ 117.079061] sdhci-tegra 3400000.sdhci: Tuning already done,
>>> restoring the best tap value : 112
>>> [ 117.081179] xhci-tegra 3530000.xhci: exiting ELPG
>>> [ 117.081798] xhci-tegra 3530000.xhci: Firmware timestamp: 2016-09-01
>>> 11:32:41 UTC, Version: 55.05 release
>>> [ 117.085202] xhci-tegra 3530000.xhci: exiting ELPG done
>>> [ 117.085204] xhci-tegra 3530000.xhci: entering ELPG
>>> [ 117.087770] xhci-tegra 3530000.xhci: entering ELPG done
>>> [ 117.087775] Wake76 for irq=199
>>> [ 117.087777] Wake77 for irq=199
>>> [ 117.087778] Wake78 for irq=199
>>> [ 117.087779] Wake79 for irq=199
>>> [ 117.087780] Wake80 for irq=199
>>> [ 117.087781] Wake81 for irq=199
>>> [ 117.087782] Wake82 for irq=199
>>> [ 117.087784] Enabling wake76
>>> [ 117.087785] Enabling wake77
>>> [ 117.087786] Enabling wake78
>>> [ 117.087787] Enabling wake79
>>> [ 117.087788] Enabling wake80
>>> [ 117.087789] Enabling wake81
>>> [ 117.087790] Enabling wake82
>>> [ 117.087891] tegra186-cam-rtcpu b000000.rtcpu: sce gets halted
>>> [ 117.090012] Wake24 for irq=241
>>> [ 117.090015] Enabling wake24
>>> [ 117.090598] nct1008_nct72 7-004c: success in disabling tmp451 VDD rail
>>> [ 117.090654] gpio tegra-gpio-aon wake29 for gpio=56(FF:0)
>>> [ 117.090655] Enabling wake29
>>> [ 117.090774] gpio tegra-gpio wake53 for gpio=159(X:5)
>>> [ 117.090775] Enabling wake53
>>> [ 117.111219] tegradc 15210000.nvdisplay: suspend
>>> [ 117.111422] Wake73 for irq=42
>>> [ 117.111424] Enabling wake73
>>> [ 117.111597] bcm54xx_low_power_mode(): put phy in iddq-lp mode
>>> [ 117.113533] gpio tegra-gpio wake71 for gpio=125(P:6)
>>> [ 117.113535] Enabling wake71
>>> [ 117.113632] PM: suspend of devices complete after 34.680 msecs
>>> [ 117.114829] host1x 13e10000.host1x: suspended
>>> [ 117.114898] PM: late suspend of devices complete after 1.262 msecs
>>> [ 117.133746] PM: noirq suspend of devices complete after 18.841 msecs
>>> [ 117.133971] Disabling non-boot CPUs ...
>>> [ 117.134249] CPU3: shutdown
>>> [ 117.148582] psci: Retrying again to check for CPU kill
>>> [ 117.148586] psci: CPU3 killed.
>>> [ 117.149097] CPU4: shutdown
>>> [ 117.164584] psci: Retrying again to check for CPU kill
>>> [ 117.164589] psci: CPU4 killed.
>>> [ 117.165041] CPU5: shutdown
>>> [ 117.180572] psci: Retrying again to check for CPU kill
>>> [ 117.180576] psci: CPU5 killed.
>>> [ 117.180834] Entered SC7
>>> [ 117.180834] Wake[31-0] level=0x40000000
>>> [ 117.180834] Wake[63-32] level=0x0
>>> [ 117.180834] Wake[95-64] level=0x7f2a0
>>> [ 117.180834] Wake[31-0] enable=0x21000000
>>> [ 117.180834] Wake[63-32] enable=0x200000
>>> [ 117.180834] Wake[95-64] enable=0x7f280
>>> [ 117.180834] Wake[31-0] route=0x21000000
>>> [ 117.180834] Wake[63-32] route=0x200000
>>> [ 117.180834] Wake[95-64] route=0x7f280
>>> ----
>>> [ 117.180834] Wake[32:0] status=0x0
>>> [ 117.180834] Wake[64:32] status=0x0
>>> [ 117.180834] Wake[96:64] status=0x0
>>> [ 117.180834] Exited SC7
>>> [ 117.180834] bpmp: waiting for handshake
>>> [ 117.180834] bpmp: synchronizing channels
>>> [ 117.180834] bpmp: channels synchronized
>>> [ 117.180869] Enabling non-boot CPUs ...
>>> [ 117.181067] CPU3: Booted secondary processor [411fd073]
>>> [ 117.181198] CPU3 is up
>>> [ 117.181353] CPU4: Booted secondary processor [411fd073]
>>> [ 117.181455] CPU4 is up
>>> [ 117.181609] CPU5: Booted secondary processor [411fd073]
>>> [ 117.181721] CPU5 is up
>>> [ 117.182740] xhci-tegra 3530000.xhci: exiting ELPG
>>> [ 117.183221] xhci-tegra 3530000.xhci: Firmware timestamp: 2016-09-01
>>> 11:32:41 UTC, Version: 55.05 release
>>> [ 117.381630] xhci-tegra 3530000.xhci: XHCI Controller not ready.
>>> Falcon state: 0x10
>>> [ 117.381633] xhci-tegra 3530000.xhci: exiting ELPG failed
>>> [ 117.381643] dpm_run_callback(): tegra_xhci_resume_noirq+0x0/0x48
>>> returns -14
>>> [ 117.381653] PM: Device 3530000.xhci failed to resume noirq: error -14
>>> [ 117.381724] PM: noirq resume of devices complete after 199.999 msecs
>>> [ 117.383100] PM: early resume of devices complete after 1.236 msecs
>>> [ 117.390964] gpio tegra-gpio wake71 for gpio=125(P:6)
>>> [ 117.390966] Disabling wake71
>>> [ 117.392317] pad_id 26: PMC_IMPL_E_33V_PWR_0 = [0x79]
>>> [ 117.392317] sdhci-tegra 3400000.sdhci: Tuning already done,
>>> restoring the best tap value : 112
>>> [ 117.392380] sdhci-tegra 3400000.sdhci: Tuning already done,
>>> restoring the best tap value : 112
>>> [ 117.393492] skipping ...
>>> [ 117.393495] skipping ...
>>> [ 117.393496] skipping ...
>>> [ 117.393498] skipping ...
>>> [ 117.393499] skipping ...
>>> [ 117.393510] skipping ...
>>> [ 117.393511] skipping ...
>>> [ 117.393512] skipping ...
>>> [ 117.461448] gpio tegra-gpio wake18 for gpio=101(M:3)
>>> [ 117.461611] Wake73 for irq=42
>>> [ 117.461613] Disabling wake73
>>> [ 117.461636] tegradc 15210000.nvdisplay: resume
>>> [ 117.461640] PD DISP0 index2 UP
>>> [ 117.462067] PD DISP1 index3 UP
>>> [ 117.462156] PD DISP2 index4 UP
>>> [ 117.468176] gk20a 17000000.gp10b: gk20a_init_fifo_setup_hw: bar1
>>> broken @ gk20a: CPU wrote 0x33, GPU read 0xbad0ac05
>>> [ 117.468179] gk20a 17000000.gp10b: gk20a_pm_finalize_poweron: failed
>>> to init gk20a fifo
>>> [ 117.481847] dpm_run_callback(): platform_pm_resume+0x0/0x58 returns -22
>>> [ 117.481850] PM: Device 17000000.gp10b failed to resume: error -22
>>> [ 117.484872] gpio tegra-gpio wake53 for gpio=159(X:5)
>>> [ 117.484874] Disabling wake53
>>> [ 117.486434] extcon-gpio-states external-connection:extcon@1: Cable
>>> state 0
>>> [ 117.486544] pwm_fan_driver pwm-fan: Enabled vdd-fan
>>> [ 117.486646] gpio tegra-gpio-aon wake29 for gpio=56(FF:0)
>>> [ 117.486647] Disabling wake29
>>> [ 117.487977] nct1008_nct72 7-004c: success in enabling tmp451 VDD rail
>>> [ 117.487982] nct1008_nct72 7-004c: nct1008_read_reg: err -16
>>> [ 117.487985] nct1008_nct72 7-004c: nct1008_write_reg: err -16
>>> [ 117.487988] nct1008_nct72 7-004c:
>>> [ 117.487988] exit nct1008_configure_sensor, err=-16
>>> [ 117.487990] nct1008_nct72 7-004c: nct1008_write_reg: err -16
>>> [ 117.487993] nct1008_nct72 7-004c: nct1008_enable, line=1174, i2c
>>> write error=-16
>>> [ 117.487996] nct1008_nct72 7-004c: Error: nct1008_resume_powerdown,
>>> error=-16
>>> [ 117.488004] dpm_run_callback(): nct1008_resume+0x0/0x140 returns -16
>>> [ 117.488006] PM: Device 7-004c failed to resume: error -16
>>> [ 117.540893] Wake24 for irq=241
>>> [ 117.540895] Disabling wake24
>>> [ 117.541684] tegra-xudc-new 3550000.xudc: exiting ELPG
>>> [ 117.542833] tegra-xudc-new 3550000.xudc: exiting ELPG done
>>> [ 117.543777] tegra186-cam-rtcpu b000000.rtcpu: booting sce with
>>> Camera RTCPU FW
>>> [ 117.543781] tegra186-cam-rtcpu b000000.rtcpu: sce gets unhalted
>>> [ 117.543825] tegra186-cam-rtcpu b000000.rtcpu: enabling tracing
>>> [ 117.543872] xhci-tegra 3530000.xhci: exiting ELPG
>>> [ 117.544128] xhci-tegra 3530000.xhci: Firmware already loaded, Falcon
>>> state 0x10
>>> [ 118.044718] xhci-tegra 3530000.xhci: exiting ELPG done
>>> [ 118.044733] Wake76 for irq=199
>>> [ 118.044735] Wake77 for irq=199
>>> [ 118.044736] Wake78 for irq=199
>>> [ 118.044737] Wake79 for irq=199
>>> [ 118.044738] Wake80 for irq=199
>>> [ 118.044739] Wake81 for irq=199
>>> [ 118.044740] Wake82 for irq=199
>>> [ 118.044742] Disabling wake76
>>> [ 118.044743] Disabling wake77
>>> [ 118.044744] Disabling wake78
>>> [ 118.044745] Disabling wake79
>>> [ 118.044746] Disabling wake80
>>> [ 118.044747] Disabling wake81
>>> [ 118.044748] Disabling wake82
>>> [ 118.044783] pwm_fan_driver pwm-fan: Disabled vdd-fan
>>> [ 118.044784] _mmc_resume: [PINTU]: Enter
>>> [ 118.044787] _mmc_resume: [PINTU]: mmc_card_in_sleep
>>> [ 118.044821] _mmc_resume: [PINTU]: Done
>>> [ 118.044824] mmc0: error -110 during resume (card was removed?)
>>> [ 118.234270] pad_id 26: PMC_IMPL_E_33V_PWR_0 = [0x79]
>>> [ 118.258208] pad_id 26: PMC_IMPL_E_33V_PWR_0 = [0x69]
>>> [ 118.258208] sdhci-tegra 3400000.sdhci: Tuning already done,
>>> restoring the best tap value : 112
>>> [ 120.496556] tegra-hda 3510000.hda: azx_get_response timeout,
>>> switching to polling mode: last cmd=0x30170500
>>> [ 121.500555] tegra-hda 3510000.hda: azx_get_response timeout,
>>> switching to single_cmd mode: last cmd=0x30170500
>>> [ 121.501139] PM: resume of devices complete after 4118.033 msecs
>>> [ 121.517871] eqos 2490000.ether_qos eth0: Link is Up - 100Mbps/Full -
>>> flow control rx/tx
>>> --
>>> [ 122.335653] Restarting tasks ...
>>> [ 122.339023] tegra-xudc-new 3550000.xudc: entering ELPG
>>> [ 122.345787] xhci-tegra 3530000.xhci: entering ELPG
>>> [ 122.347145] tegra-xudc-new 3550000.xudc: entering ELPG done
>>> [ 122.347558] nct1008_nct72 7-004c: nct1008_read_reg: err -16
>>> [ 122.347561] thermal thermal_zone5: failed to read out thermal zone (-1)
>>> [ 122.347565] nct1008_nct72 7-004c: nct1008_read_reg: err -16
>>> [ 122.347568] thermal thermal_zone6: failed to read out thermal zone (-1)
>>> [ 122.385092] PM: suspend exit 2016-05-06 05:42:04.775600032 UTC
>>> [ 122.386487] xhci-tegra 3530000.xhci: entering ELPG done
>>> [ 124.605296] mmcblk0: error -110 sending status command, retrying
>>> [ 124.613771] mmcblk0: error -110 sending status command, retrying
>>> [ 124.622175] mmcblk0: error -110 sending status command, aborting
>>> [ 124.631538] mmc_reset: [PINTU]: Enter
>>> [ 124.638572] blk_update_request: I/O error, dev mmcblk0, sector 59745989
>>> [ 124.648740] blk_update_request: I/O error, dev mmcblk0, sector 59745990
>>> [ 124.658768] blk_update_request: I/O error, dev mmcblk0, sector 59745991
>>> [ 124.668689] blk_update_request: I/O error, dev mmcblk0, sector 59745992
>>> [ 124.678609] blk_update_request: I/O error, dev mmcblk0, sector 59745993
>>> [ 124.688666] mmcblk0: error -110 sending status command, retrying
>>> [ 124.697840] mmcblk0: error -110 sending status command, retrying
>>> [ 124.706903] mmcblk0: error -110 sending status command, aborting
>>> [ 124.715858] blk_update_request: I/O error, dev mmcblk0, sector 59745994
>>> [ 124.725339] blk_update_request: I/O error, dev mmcblk0, sector 59745995
>>> [ 124.734690] blk_update_request: I/O error, dev mmcblk0, sector 59745996
>>> [ 124.743936] blk_update_request: I/O error, dev mmcblk0, sector 59745997
>>> [ 124.753041] blk_update_request: I/O error, dev mmcblk0, sector 59745998
>>> [ 124.762252] mmcblk0: error -110 sending status command, retrying
>>> [ 124.770656] mmcblk0: error -110 sending status command, retrying
>>> [ 124.778977] mmcblk0: error -110 sending status command, aborting
>>> [ 124.789002] mmcblk0: error -110 sending status command, retrying
>>> [ 124.797177] mmcblk0: error -110 sending status command, retrying
>>> [ 124.805285] mmcblk0: error -110 sending status command, aborting
>>> [ 124.814281] mmcblk0: error -110 sending status command, retrying
>>> [ 124.822247] mmcblk0: error -110 sending status command, retrying
>>> [ 124.830092] mmcblk0: error -110 sending status command, aborting
>>> [ 124.837840] FAT-fs (mmcblk0p17): FAT read failed (blocknr 32)
>>>
>>> -----------------------------------------------------------------------------------------------------
>>>
>>>
>>>
>>>
>>>
>>> On Mon, Nov 20, 2017 at 12:48 PM, Pintu Kumar <pintu.ping-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>> wrote:
>>>> Hi,
>>>>
>>>> I am trying to verify suspend-to-disk on jetson-tx2 board (nvidia
>>>> tegra186).
>>>> Suspend is working fine, but during resume emmc is failing to resume.
>>>> Kernel version: 4.4
>>>> Repo: https://nv-tegra.nvidia.com/gitweb/?p=linux-4.4.git;a=summary
>>>>
>>>>
>>>> It returns with:
>>>> mmc0: error -110 during resume (card was removed?)
>>>>
>>>> Please see the complete logs below.
>>>>
>>>> I tried to add some prints in mmc driver to check the cause.
>>>> It seems that mmc is not responding during resume.
>>>> [  137.125314] mmc_sleep: ERROR: mmc_wait_for_cmd, ret: -110
>>>>
>>>> Do you have any pointers to fix/debug this issue?
>>>> When I see the linux kernel mainline kernel-4.14 (latest), I could see
>>>> that there are some patches in drivers/mmc/core/* which are missing in
>>>> jetson tx2 kernel version-4.4.
>>>> Do you think any of the latest patches may help to solve this issue?
>>>> If yes, can you point to some of relevant once?
>>>>
>>>>
>>>> Please help.
>>>>
>>>>
>>>> Thanks,
>>>> Pintu
>>>>
>>>> LOGS:
>>>> -----------------------------------------------------------
>>>> ## Booting ...
>>>> [ 117.079061] sdhci-tegra 3400000.sdhci: Tuning already done,
>>>> restoring the best tap value : 112
>>>> [ 117.081179] xhci-tegra 3530000.xhci: exiting ELPG
>>>> [ 117.081798] xhci-tegra 3530000.xhci: Firmware timestamp: 2016-09-01
>>>> 11:32:41 UTC, Version: 55.05 release
>>>> [ 117.085202] xhci-tegra 3530000.xhci: exiting ELPG done
>>>> [ 117.085204] xhci-tegra 3530000.xhci: entering ELPG
>>>> [ 117.087770] xhci-tegra 3530000.xhci: entering ELPG done
>>>> [ 117.087775] Wake76 for irq=199
>>>> [ 117.087777] Wake77 for irq=199
>>>> [ 117.087778] Wake78 for irq=199
>>>> [ 117.087779] Wake79 for irq=199
>>>> [ 117.087780] Wake80 for irq=199
>>>> [ 117.087781] Wake81 for irq=199
>>>> [ 117.087782] Wake82 for irq=199
>>>> [ 117.087784] Enabling wake76
>>>> [ 117.087785] Enabling wake77
>>>> [ 117.087786] Enabling wake78
>>>> [ 117.087787] Enabling wake79
>>>> [ 117.087788] Enabling wake80
>>>> [ 117.087789] Enabling wake81
>>>> [ 117.087790] Enabling wake82
>>>> [ 117.087891] tegra186-cam-rtcpu b000000.rtcpu: sce gets halted
>>>> [ 117.090012] Wake24 for irq=241
>>>> [ 117.090015] Enabling wake24
>>>> [ 117.090598] nct1008_nct72 7-004c: success in disabling tmp451 VDD rail
>>>> [ 117.090654] gpio tegra-gpio-aon wake29 for gpio=56(FF:0)
>>>> [ 117.090655] Enabling wake29
>>>> [ 117.090774] gpio tegra-gpio wake53 for gpio=159(X:5)
>>>> [ 117.090775] Enabling wake53
>>>> [ 117.111219] tegradc 15210000.nvdisplay: suspend
>>>> [ 117.111422] Wake73 for irq=42
>>>> [ 117.111424] Enabling wake73
>>>> [ 117.111597] bcm54xx_low_power_mode(): put phy in iddq-lp mode
>>>> [ 117.113533] gpio tegra-gpio wake71 for gpio=125(P:6)
>>>> [ 117.113535] Enabling wake71
>>>> [ 117.113632] PM: suspend of devices complete after 34.680 msecs
>>>> [ 117.114829] host1x 13e10000.host1x: suspended
>>>> [ 117.114898] PM: late suspend of devices complete after 1.262 msecs
>>>> [ 117.133746] PM: noirq suspend of devices complete after 18.841 msecs
>>>> [ 117.133971] Disabling non-boot CPUs ...
>>>> [ 117.134249] CPU3: shutdown
>>>> [ 117.148582] psci: Retrying again to check for CPU kill
>>>> [ 117.148586] psci: CPU3 killed.
>>>> [ 117.149097] CPU4: shutdown
>>>> [ 117.164584] psci: Retrying again to check for CPU kill
>>>> [ 117.164589] psci: CPU4 killed.
>>>> [ 117.165041] CPU5: shutdown
>>>> [ 117.180572] psci: Retrying again to check for CPU kill
>>>> [ 117.180576] psci: CPU5 killed.
>>>> [ 117.180834] Entered SC7
>>>> [ 117.180834] Wake[31-0] level=0x40000000
>>>> [ 117.180834] Wake[63-32] level=0x0
>>>> [ 117.180834] Wake[95-64] level=0x7f2a0
>>>> [ 117.180834] Wake[31-0] enable=0x21000000
>>>> [ 117.180834] Wake[63-32] enable=0x200000
>>>> [ 117.180834] Wake[95-64] enable=0x7f280
>>>> [ 117.180834] Wake[31-0] route=0x21000000
>>>> [ 117.180834] Wake[63-32] route=0x200000
>>>> [ 117.180834] Wake[95-64] route=0x7f280
>>>> ----
>>>> [ 117.180834] Wake[32:0] status=0x0
>>>> [ 117.180834] Wake[64:32] status=0x0
>>>> [ 117.180834] Wake[96:64] status=0x0
>>>> [ 117.180834] Exited SC7
>>>> [ 117.180834] bpmp: waiting for handshake
>>>> [ 117.180834] bpmp: synchronizing channels
>>>> [ 117.180834] bpmp: channels synchronized
>>>> [ 117.180869] Enabling non-boot CPUs ...
>>>> [ 117.181067] CPU3: Booted secondary processor [411fd073]
>>>> [ 117.181198] CPU3 is up
>>>> [ 117.181353] CPU4: Booted secondary processor [411fd073]
>>>> [ 117.181455] CPU4 is up
>>>> [ 117.181609] CPU5: Booted secondary processor [411fd073]
>>>> [ 117.181721] CPU5 is up
>>>> [ 117.182740] xhci-tegra 3530000.xhci: exiting ELPG
>>>> [ 117.183221] xhci-tegra 3530000.xhci: Firmware timestamp: 2016-09-01
>>>> 11:32:41 UTC, Version: 55.05 release
>>>> [ 117.381630] xhci-tegra 3530000.xhci: XHCI Controller not ready.
>>>> Falcon state: 0x10
>>>> [ 117.381633] xhci-tegra 3530000.xhci: exiting ELPG failed
>>>> [ 117.381643] dpm_run_callback(): tegra_xhci_resume_noirq+0x0/0x48
>>>> returns -14
>>>> [ 117.381653] PM: Device 3530000.xhci failed to resume noirq: error -14
>>>> [ 117.381724] PM: noirq resume of devices complete after 199.999 msecs
>>>> [ 117.383100] PM: early resume of devices complete after 1.236 msecs
>>>> [ 117.390964] gpio tegra-gpio wake71 for gpio=125(P:6)
>>>> [ 117.390966] Disabling wake71
>>>> [ 117.392317] pad_id 26: PMC_IMPL_E_33V_PWR_0 = [0x79]
>>>> [ 117.392317] sdhci-tegra 3400000.sdhci: Tuning already done,
>>>> restoring the best tap value : 112
>>>> [ 117.392380] sdhci-tegra 3400000.sdhci: Tuning already done,
>>>> restoring the best tap value : 112
>>>> [ 117.393492] skipping ...
>>>> [ 117.393495] skipping ...
>>>> [ 117.393496] skipping ...
>>>> [ 117.393498] skipping ...
>>>> [ 117.393499] skipping ...
>>>> [ 117.393510] skipping ...
>>>> [ 117.393511] skipping ...
>>>> [ 117.393512] skipping ...
>>>> [ 117.461448] gpio tegra-gpio wake18 for gpio=101(M:3)
>>>> [ 117.461611] Wake73 for irq=42
>>>> [ 117.461613] Disabling wake73
>>>> [ 117.461636] tegradc 15210000.nvdisplay: resume
>>>> [ 117.461640] PD DISP0 index2 UP
>>>> [ 117.462067] PD DISP1 index3 UP
>>>> [ 117.462156] PD DISP2 index4 UP
>>>> [ 117.468176] gk20a 17000000.gp10b: gk20a_init_fifo_setup_hw: bar1
>>>> broken @ gk20a: CPU wrote 0x33, GPU read 0xbad0ac05
>>>> [ 117.468179] gk20a 17000000.gp10b: gk20a_pm_finalize_poweron: failed
>>>> to init gk20a fifo
>>>> [ 117.481847] dpm_run_callback(): platform_pm_resume+0x0/0x58 returns
>>>> -22
>>>> [ 117.481850] PM: Device 17000000.gp10b failed to resume: error -22
>>>> [ 117.484872] gpio tegra-gpio wake53 for gpio=159(X:5)
>>>> [ 117.484874] Disabling wake53
>>>> [ 117.486434] extcon-gpio-states external-connection:extcon@1: Cable
>>>> state 0
>>>> [ 117.486544] pwm_fan_driver pwm-fan: Enabled vdd-fan
>>>> [ 117.486646] gpio tegra-gpio-aon wake29 for gpio=56(FF:0)
>>>> [ 117.486647] Disabling wake29
>>>> [ 117.487977] nct1008_nct72 7-004c: success in enabling tmp451 VDD rail
>>>> [ 117.487982] nct1008_nct72 7-004c: nct1008_read_reg: err -16
>>>> [ 117.487985] nct1008_nct72 7-004c: nct1008_write_reg: err -16
>>>> [ 117.487988] nct1008_nct72 7-004c:
>>>> [ 117.487988] exit nct1008_configure_sensor, err=-16
>>>> [ 117.487990] nct1008_nct72 7-004c: nct1008_write_reg: err -16
>>>> [ 117.487993] nct1008_nct72 7-004c: nct1008_enable, line=1174, i2c
>>>> write error=-16
>>>> [ 117.487996] nct1008_nct72 7-004c: Error: nct1008_resume_powerdown,
>>>> error=-16
>>>> [ 117.488004] dpm_run_callback(): nct1008_resume+0x0/0x140 returns -16
>>>> [ 117.488006] PM: Device 7-004c failed to resume: error -16
>>>> [ 117.540893] Wake24 for irq=241
>>>> [ 117.540895] Disabling wake24
>>>> [ 117.541684] tegra-xudc-new 3550000.xudc: exiting ELPG
>>>> [ 117.542833] tegra-xudc-new 3550000.xudc: exiting ELPG done
>>>> [ 117.543777] tegra186-cam-rtcpu b000000.rtcpu: booting sce with
>>>> Camera RTCPU FW
>>>> [ 117.543781] tegra186-cam-rtcpu b000000.rtcpu: sce gets unhalted
>>>> [ 117.543825] tegra186-cam-rtcpu b000000.rtcpu: enabling tracing
>>>> [ 117.543872] xhci-tegra 3530000.xhci: exiting ELPG
>>>> [ 117.544128] xhci-tegra 3530000.xhci: Firmware already loaded, Falcon
>>>> state 0x10
>>>> [ 118.044718] xhci-tegra 3530000.xhci: exiting ELPG done
>>>> [ 118.044733] Wake76 for irq=199
>>>> [ 118.044735] Wake77 for irq=199
>>>> [ 118.044736] Wake78 for irq=199
>>>> [ 118.044737] Wake79 for irq=199
>>>> [ 118.044738] Wake80 for irq=199
>>>> [ 118.044739] Wake81 for irq=199
>>>> [ 118.044740] Wake82 for irq=199
>>>> [ 118.044742] Disabling wake76
>>>> [ 118.044743] Disabling wake77
>>>> [ 118.044744] Disabling wake78
>>>> [ 118.044745] Disabling wake79
>>>> [ 118.044746] Disabling wake80
>>>> [ 118.044747] Disabling wake81
>>>> [ 118.044748] Disabling wake82
>>>> [ 118.044783] pwm_fan_driver pwm-fan: Disabled vdd-fan
>>>> [ 118.044784] _mmc_resume: [PINTU]: Enter
>>>> [ 118.044787] _mmc_resume: [PINTU]: mmc_card_in_sleep
>>>> [ 118.044821] _mmc_resume: [PINTU]: Done
>>>> [ 118.044824] mmc0: error -110 during resume (card was removed?)
>>>> [ 118.234270] pad_id 26: PMC_IMPL_E_33V_PWR_0 = [0x79]
>>>> [ 118.258208] pad_id 26: PMC_IMPL_E_33V_PWR_0 = [0x69]
>>>> [ 118.258208] sdhci-tegra 3400000.sdhci: Tuning already done,
>>>> restoring the best tap value : 112
>>>> [ 120.496556] tegra-hda 3510000.hda: azx_get_response timeout,
>>>> switching to polling mode: last cmd=0x30170500
>>>> [ 121.500555] tegra-hda 3510000.hda: azx_get_response timeout,
>>>> switching to single_cmd mode: last cmd=0x30170500
>>>> [ 121.501139] PM: resume of devices complete after 4118.033 msecs
>>>> [ 121.517871] eqos 2490000.ether_qos eth0: Link is Up - 100Mbps/Full -
>>>> flow control rx/tx
>>>> --
>>>> [ 122.335653] Restarting tasks ...
>>>> [ 122.339023] tegra-xudc-new 3550000.xudc: entering ELPG
>>>> [ 122.345787] xhci-tegra 3530000.xhci: entering ELPG
>>>> [ 122.347145] tegra-xudc-new 3550000.xudc: entering ELPG done
>>>> [ 122.347558] nct1008_nct72 7-004c: nct1008_read_reg: err -16
>>>> [ 122.347561] thermal thermal_zone5: failed to read out thermal zone
>>>> (-1)
>>>> [ 122.347565] nct1008_nct72 7-004c: nct1008_read_reg: err -16
>>>> [ 122.347568] thermal thermal_zone6: failed to read out thermal zone
>>>> (-1)
>>>> [ 122.385092] PM: suspend exit 2016-05-06 05:42:04.775600032 UTC
>>>> [ 122.386487] xhci-tegra 3530000.xhci: entering ELPG done
>>>> [ 124.605296] mmcblk0: error -110 sending status command, retrying
>>>> [ 124.613771] mmcblk0: error -110 sending status command, retrying
>>>> [ 124.622175] mmcblk0: error -110 sending status command, aborting
>>>> [ 124.631538] mmc_reset: [PINTU]: Enter
>>>> [ 124.638572] blk_update_request: I/O error, dev mmcblk0, sector
>>>> 59745989
>>>> [ 124.648740] blk_update_request: I/O error, dev mmcblk0, sector
>>>> 59745990
>>>> [ 124.658768] blk_update_request: I/O error, dev mmcblk0, sector
>>>> 59745991
>>>> [ 124.668689] blk_update_request: I/O error, dev mmcblk0, sector
>>>> 59745992
>>>> [ 124.678609] blk_update_request: I/O error, dev mmcblk0, sector
>>>> 59745993
>>>> [ 124.688666] mmcblk0: error -110 sending status command, retrying
>>>> [ 124.697840] mmcblk0: error -110 sending status command, retrying
>>>> [ 124.706903] mmcblk0: error -110 sending status command, aborting
>>>> [ 124.715858] blk_update_request: I/O error, dev mmcblk0, sector
>>>> 59745994
>>>> [ 124.725339] blk_update_request: I/O error, dev mmcblk0, sector
>>>> 59745995
>>>> [ 124.734690] blk_update_request: I/O error, dev mmcblk0, sector
>>>> 59745996
>>>> [ 124.743936] blk_update_request: I/O error, dev mmcblk0, sector
>>>> 59745997
>>>> [ 124.753041] blk_update_request: I/O error, dev mmcblk0, sector
>>>> 59745998
>>>> [ 124.762252] mmcblk0: error -110 sending status command, retrying
>>>> [ 124.770656] mmcblk0: error -110 sending status command, retrying
>>>> [ 124.778977] mmcblk0: error -110 sending status command, aborting
>>>> [ 124.789002] mmcblk0: error -110 sending status command, retrying
>>>> [ 124.797177] mmcblk0: error -110 sending status command, retrying
>>>> [ 124.805285] mmcblk0: error -110 sending status command, aborting
>>>> [ 124.814281] mmcblk0: error -110 sending status command, retrying
>>>> [ 124.822247] mmcblk0: error -110 sending status command, retrying
>>>> [ 124.830092] mmcblk0: error -110 sending status command, aborting
>>>> [ 124.837840] FAT-fs (mmcblk0p17): FAT read failed (blocknr 32)
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>
> --
> nvpublic
