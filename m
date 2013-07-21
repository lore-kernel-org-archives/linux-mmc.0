From: =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Subject: kernel panic in sg_complete
Date: Mon, 22 Jul 2013 01:00:41 +0200
Message-ID: <CA+GA0_sAqCz8BzCr8_6iaAzd+1U91WviuAPag7rGCCzDFK1HYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=089e013a2d8668d70304e20d8704
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:40099 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602Ab3GUXAl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 21 Jul 2013 19:00:41 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chris Ball <cjb@laptop.org>

--089e013a2d8668d70304e20d8704
Content-Type: text/plain; charset=UTF-8

Hi

Few days ago I fried (?) my SD card (with custom Arduino-based hw :)
and now every
time I insert it into my Linux laptop, after ~10 seconds, kernel panics:

[  258.288466] BUG: unable to handle kernel NULL pointer dereference
at 0000000000000040
[  258.289742] IP: [<ffffffff814d0849>] sg_complete+0xb9/0x1d0
[  258.290997] PGD 0
[  258.292222] Oops: 0000 [#1] PREEMPT SMP
[  258.293443] Modules linked in: arc4 iwldvm mac80211 dm_crypt
iwlwifi snd_hda_codec_hdmi cfg80211 snd_hda_codec_idt snd_hda_intel
snd_hda_codec uvcvideo rts5139(C) snd_hwdep snd_pcm videobuf2_core
videodev snd_seq_midi snd_rawmidi bnep videobuf2_vmalloc
snd_seq_midi_event videobuf2_memops snd_seq coretemp psmouse snd_timer
snd_seq_device snd rfcomm serio_raw dell_wmi btusb lpc_ich microcode
soundcore snd_page_alloc dell_laptop dcdbas sparse_keymap bluetooth
mac_hid parport_pc ppdev lp parport binfmt_misc hid_generic i915
ghash_clmulni_intel cryptd usbhid drm_kms_helper hid drm i2c_algo_bit
video ahci libahci wmi
[  258.299260] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G         C   3.10.1 #22
[  258.300711] Hardware name: Dell Inc.          Inspiron 7720/04M3YM,
BIOS A07 08/16/2012
[  258.302190] task: ffff88013a344560 ti: ffff88013a34e000 task.ti:
ffff88013a34e000
[  258.303681] RIP: 0010:[<ffffffff814d0849>]  [<ffffffff814d0849>]
sg_complete+0xb9/0x1d0
[  258.305204] RSP: 0018:ffff88013f2c3cc8  EFLAGS: 00010002
[  258.306723] RAX: 00000000ffffff92 RBX: ffff88012ee30a70 RCX: 00000000000019ff
[  258.308260] RDX: ffff880130f17400 RSI: 0000000000000000 RDI: 0000000000000001
[  258.309807] RBP: ffff88013f2c3cf8 R08: ffffffff81a3b1a8 R09: 00000000ffffff98
[  258.311350] R10: 0000000000000001 R11: 0000000000000036 R12: 00000000ffffff98
[  258.312887] R13: ffff88012f86ac00 R14: ffff88012ee30a80 R15: ffff8801302a7118
[  258.314433] FS:  0000000000000000(0000) GS:ffff88013f2c0000(0000)
knlGS:0000000000000000
[  258.315998] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  258.317555] CR2: 0000000000000040 CR3: 0000000001c0b000 CR4: 00000000001407e0
[  258.319138] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  258.320724] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[  258.322298] Stack:
[  258.323866]  ffff88012f86ac00 00000000ffffff98 ffff88012f86ac00
00000000ffffff98
[  258.325485]  ffff880130e18a74 ffff880130e18800 ffff88013f2c3d18
ffffffff814cd584
[  258.327105]  ffff88012f86ac00 00000000ffffff8d ffff88013f2c3d48
ffffffff814e1742
[  258.328724] Call Trace:
[  258.330317]  <IRQ>
[  258.330330]  [<ffffffff814cd584>] usb_hcd_giveback_urb+0x44/0xa0
[  258.333499]  [<ffffffff814e1742>] ehci_urb_done+0x72/0xb0
[  258.335092]  [<ffffffff814e1d1e>] qh_completions+0x33e/0x430
[  258.336687]  [<ffffffff814e1f58>] end_unlink_async+0x148/0x250
[  258.338280]  [<ffffffff814e47d8>] ehci_irq+0xa8/0x2e0
[  258.339872]  [<ffffffff814cc90e>] usb_hcd_irq+0x2e/0x50
[  258.341460]  [<ffffffff811164a5>] handle_irq_event_percpu+0x75/0x250
[  258.343057]  [<ffffffff811166c8>] handle_irq_event+0x48/0x70
[  258.344642]  [<ffffffff811197ea>] handle_fasteoi_irq+0x5a/0x100
[  258.346214]  [<ffffffff81047222>] handle_irq+0x22/0x40
[  258.347784]  [<ffffffff816999fa>] do_IRQ+0x5a/0xd0
[  258.349355]  [<ffffffff81690caa>] common_interrupt+0x6a/0x6a
[  258.350909]  <EOI>
[  258.350922]  [<ffffffff810aed0a>] ? __hrtimer_start_range_ns+0x16a/0x460
[  258.354032]  [<ffffffff81547bbb>] ? cpuidle_enter_state+0x5b/0xe0
[  258.355595]  [<ffffffff81547bb7>] ? cpuidle_enter_state+0x57/0xe0
[  258.357150]  [<ffffffff81547cfb>] cpuidle_idle_call+0xbb/0x260
[  258.358698]  [<ffffffff8104e0fe>] arch_cpu_idle+0xe/0x30
[  258.360241]  [<ffffffff810d70b0>] cpu_startup_entry+0xd0/0x2d0
[  258.361758]  [<ffffffff810df126>] ? clockevents_config_and_register+0x26/0x30
[  258.363263]  [<ffffffff8167efb6>] start_secondary+0x1e3/0x1ea
[  258.364753] Code: 00 00 31 d2 45 85 c9 74 b7 41 f6 45 65 02 48 c7
c2 b7 b1 a3 81 45 89 e1 48 8b 73 18 49 c7 c0 a8 b1 a3 81 4c 0f 44 c2
49 8b 55 50 <48> 8b 7e 40 0f b6 4a 02 89 04 24 48 8d 56 04 48 8b 3f 31
c0 48
[  258.368220] RIP  [<ffffffff814d0849>] sg_complete+0xb9/0x1d0
[  258.369869]  RSP <ffff88013f2c3cc8>
[  258.371496] CR2: 0000000000000040
[  258.373097] ---[ end trace e81441c38e5ace26 ]---
[  258.374690] Kernel panic - not syncing: Fatal exception in interrupt
[  258.376291] drm_kms_helper: panic occurred, switching back to text console

It happens both with 3.10.1 and 3.9.11 kernels.

I traced it to io->dev being NULL in sg_complete.

With the attached bandage Linux survives:

[  138.375564] sd 6:0:0:0: [sdb] 3862528 512-byte logical blocks:
(1.97 GB/1.84 GiB)
[  138.375717] sd 6:0:0:0: [sdb] Cache data unavailable
[  138.375721] sd 6:0:0:0: [sdb] Assuming drive cache: write through
[  138.378277] sd 6:0:0:0: [sdb] Cache data unavailable
[  138.378279] sd 6:0:0:0: [sdb] Assuming drive cache: write through
[  138.394977]  sdb: sdb1
[  148.587252] (NULL device *): dev ??? ep2in scatterlist error -104/-110
[  148.589748] sd 6:0:0:0: [sdb] Unhandled sense code
[  148.589753] sd 6:0:0:0: [sdb]
[  148.589756] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[  148.589757] sd 6:0:0:0: [sdb]
[  148.589759] Sense Key : Medium Error [current]
[  148.589763] sd 6:0:0:0: [sdb]
[  148.589765] Add. Sense: Unrecovered read error
[  148.589767] sd 6:0:0:0: [sdb] CDB:
[  148.589769] Read(10): 28 00 00 00 03 ff 00 00 08 00
[  148.589777] end_request: critical target error, dev sdb, sector 1023
[  148.591429] Buffer I/O error on device sdb1, logical block 888
[  148.593007] Buffer I/O error on device sdb1, logical block 889
[  148.594563] Buffer I/O error on device sdb1, logical block 890
[  148.596126] Buffer I/O error on device sdb1, logical block 891
[  148.597676] Buffer I/O error on device sdb1, logical block 892
[  148.599231] Buffer I/O error on device sdb1, logical block 893
[  148.600755] Buffer I/O error on device sdb1, logical block 894
[  148.602236] Buffer I/O error on device sdb1, logical block 895
[  161.619466] sd 6:0:0:0: [sdb] Unhandled sense code
[  161.619473] sd 6:0:0:0: [sdb]
[  161.619476] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[  161.619480] sd 6:0:0:0: [sdb]
[  161.619482] Sense Key : Medium Error [current]
[  161.619488] sd 6:0:0:0: [sdb]
[  161.619492] Add. Sense: Unrecovered read error
[  161.619497] sd 6:0:0:0: [sdb] CDB:
[  161.619499] Read(10): 28 00 00 00 03 ff 00 00 01 00
[  161.619523] end_request: critical target error, dev sdb, sector 1023
[  161.621111] Buffer I/O error on device sdb1, logical block 888
[  164.626837] sd 6:0:0:0: [sdb] Unhandled sense code
[  164.626843] sd 6:0:0:0: [sdb]
[  164.626847] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[  164.626850] sd 6:0:0:0: [sdb]
[  164.626852] Sense Key : Medium Error [current]
[  164.626857] sd 6:0:0:0: [sdb]
[  164.626860] Add. Sense: Unrecovered read error
[  164.626863] sd 6:0:0:0: [sdb] CDB:
[  164.626865] Read(10): 28 00 00 00 04 00 00 00 07 00
[  164.626878] end_request: critical target error, dev sdb, sector 1024
[  164.628305] Buffer I/O error on device sdb1, logical block 889
[  164.629646] Buffer I/O error on device sdb1, logical block 890
[  164.631047] Buffer I/O error on device sdb1, logical block 891
[  164.632357] Buffer I/O error on device sdb1, logical block 892
[  164.633673] Buffer I/O error on device sdb1, logical block 893
[  164.634984] Buffer I/O error on device sdb1, logical block 894
[  164.636257] Buffer I/O error on device sdb1, logical block 895
[  167.642260] sd 6:0:0:0: [sdb] Unhandled sense code
[  167.642266] sd 6:0:0:0: [sdb]
[  167.642268] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[  167.642271] sd 6:0:0:0: [sdb]
[  167.642273] Sense Key : Medium Error [current]
[  167.642277] sd 6:0:0:0: [sdb]
[  167.642280] Add. Sense: Unrecovered read error
[  167.642282] sd 6:0:0:0: [sdb] CDB:
[  167.642284] Read(10): 28 00 00 00 02 87 00 00 08 00
[  167.642294] end_request: critical target error, dev sdb, sector 647
[  167.643372] Buffer I/O error on device sdb1, logical block 512
[  167.644372] Buffer I/O error on device sdb1, logical block 513
[  170.649714] sd 6:0:0:0: [sdb] Unhandled sense code
[  170.649720] sd 6:0:0:0: [sdb]
[  170.649723] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[  170.649725] sd 6:0:0:0: [sdb]
[  170.649727] Sense Key : Medium Error [current]
[  170.649730] sd 6:0:0:0: [sdb]
[  170.649733] Add. Sense: Unrecovered read error
[  170.649735] sd 6:0:0:0: [sdb] CDB:
[  170.649737] Read(10): 28 00 00 00 02 87 00 00 01 00
[  170.649746] end_request: critical target error, dev sdb, sector 647
[  170.650734] quiet_error: 6 callbacks suppressed
[  170.650736] Buffer I/O error on device sdb1, logical block 512
[  173.657089] sd 6:0:0:0: [sdb] Unhandled sense code
[  173.657096] sd 6:0:0:0: [sdb]
[  173.657099] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[  173.657101] sd 6:0:0:0: [sdb]
[  173.657103] Sense Key : Medium Error [current]
[  173.657107] sd 6:0:0:0: [sdb]
[  173.657110] Add. Sense: Unrecovered read error
[  173.657113] sd 6:0:0:0: [sdb] CDB:
[  173.657114] Read(10): 28 00 00 00 02 88 00 00 07 00
[  173.657124] end_request: critical target error, dev sdb, sector 648
[  173.658243] Buffer I/O error on device sdb1, logical block 513
[  173.659296] Buffer I/O error on device sdb1, logical block 514
[  173.660342] Buffer I/O error on device sdb1, logical block 515
[  173.661361] Buffer I/O error on device sdb1, logical block 516
[  173.662339] Buffer I/O error on device sdb1, logical block 517
[  173.663298] Buffer I/O error on device sdb1, logical block 518
[  173.664245] Buffer I/O error on device sdb1, logical block 519
[  176.668635] sd 6:0:0:0: [sdb] Unhandled sense code
[  176.668642] sd 6:0:0:0: [sdb]
[  176.668646] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[  176.668649] sd 6:0:0:0: [sdb]
[  176.668651] Sense Key : Medium Error [current]
[  176.668656] sd 6:0:0:0: [sdb]
[  176.668659] Add. Sense: Unrecovered read error
[  176.668663] sd 6:0:0:0: [sdb] CDB:
[  176.668665] Read(10): 28 00 00 00 00 a7 00 00 08 00
[  176.668678] end_request: critical target error, dev sdb, sector 167
[  176.669925] Buffer I/O error on device sdb1, logical block 32
[  176.671115] Buffer I/O error on device sdb1, logical block 33
[  179.676043] sd 6:0:0:0: [sdb] Unhandled sense code
[  179.676049] sd 6:0:0:0: [sdb]
[  179.676051] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[  179.676052] sd 6:0:0:0: [sdb]
[  179.676054] Sense Key : Medium Error [current]
[  179.676058] sd 6:0:0:0: [sdb]
[  179.676060] Add. Sense: Unrecovered read error
[  179.676063] sd 6:0:0:0: [sdb] CDB:
[  179.676065] Read(10): 28 00 00 00 00 a7 00 00 01 00
[  179.676074] end_request: critical target error, dev sdb, sector 167
[  179.677211] quiet_error: 6 callbacks suppressed
[  179.677214] Buffer I/O error on device sdb1, logical block 32
[  182.683472] sd 6:0:0:0: [sdb] Unhandled sense code
[  182.683479] sd 6:0:0:0: [sdb]
[  182.683482] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[  182.683485] sd 6:0:0:0: [sdb]
[  182.683487] Sense Key : Medium Error [current]
[  182.683492] sd 6:0:0:0: [sdb]
[  182.683495] Add. Sense: Unrecovered read error
[  182.683498] sd 6:0:0:0: [sdb] CDB:
[  182.683500] Read(10): 28 00 00 00 00 a8 00 00 07 00
[  182.683513] end_request: critical target error, dev sdb, sector 168
[  182.684790] Buffer I/O error on device sdb1, logical block 33
[  182.685930] Buffer I/O error on device sdb1, logical block 34
[  182.687095] Buffer I/O error on device sdb1, logical block 35
[  182.688193] Buffer I/O error on device sdb1, logical block 36
[  182.689254] Buffer I/O error on device sdb1, logical block 37
[  182.690333] Buffer I/O error on device sdb1, logical block 38
[  182.691365] Buffer I/O error on device sdb1, logical block 39
[  185.694924] sd 6:0:0:0: [sdb] Unhandled sense code
[  185.694931] sd 6:0:0:0: [sdb]
[  185.694934] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[  185.694937] sd 6:0:0:0: [sdb]
[  185.694938] Sense Key : Medium Error [current]
[  185.694943] sd 6:0:0:0: [sdb]
[  185.694946] Add. Sense: Unrecovered read error
[  185.694949] sd 6:0:0:0: [sdb] CDB:
[  185.694950] Read(10): 28 00 00 00 10 87 00 00 01 00
[  185.694962] end_request: critical target error, dev sdb, sector 4231
[  185.695932] Buffer I/O error on device sdb1, logical block 4096
[  188.702351] sd 6:0:0:0: [sdb] Unhandled sense code
[  188.702358] sd 6:0:0:0: [sdb]
[  188.702361] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[  188.702364] sd 6:0:0:0: [sdb]
[  188.702366] Sense Key : Medium Error [current]
[  188.702371] sd 6:0:0:0: [sdb]
[  188.702374] Add. Sense: Unrecovered read error
[  188.702377] sd 6:0:0:0: [sdb] CDB:
[  188.702379] Read(10): 28 00 00 00 10 88 00 00 07 00
[  188.702392] end_request: critical target error, dev sdb, sector 4232
[  188.703575] Buffer I/O error on device sdb1, logical block 4097
[  188.704608] Buffer I/O error on device sdb1, logical block 4098
[  188.705660] Buffer I/O error on device sdb1, logical block 4099
[  188.706702] Buffer I/O error on device sdb1, logical block 4100
[  188.707686] Buffer I/O error on device sdb1, logical block 4101
[  188.708743] Buffer I/O error on device sdb1, logical block 4102
[  188.709703] Buffer I/O error on device sdb1, logical block 4103
[  191.717720] sd 6:0:0:0: [sdb] Unhandled sense code
[  191.717727] sd 6:0:0:0: [sdb]
[  191.717730] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[  191.717733] sd 6:0:0:0: [sdb]
[  191.717736] Sense Key : Medium Error [current]
[  191.717740] sd 6:0:0:0: [sdb]
[  191.717744] Add. Sense: Unrecovered read error
[  191.717747] sd 6:0:0:0: [sdb] CDB:
[  191.717749] Read(10): 28 00 00 00 00 00 00 00 08 00
[  191.717761] end_request: critical target error, dev sdb, sector 0
[  191.718737] Buffer I/O error on device sdb, logical block 0
[  194.725258] sd 6:0:0:0: [sdb] Unhandled sense code
[  194.725264] sd 6:0:0:0: [sdb]
[  194.725267] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[  194.725269] sd 6:0:0:0: [sdb]
[  194.725271] Sense Key : Medium Error [current]
[  194.725276] sd 6:0:0:0: [sdb]
[  194.725278] Add. Sense: Unrecovered read error
[  194.725281] sd 6:0:0:0: [sdb] CDB:
[  194.725283] Read(10): 28 00 00 00 00 00 00 00 08 00
[  194.725293] end_request: critical target error, dev sdb, sector 0
[  194.726174] Buffer I/O error on device sdb, logical block 0
[  197.732800] sd 6:0:0:0: [sdb] Unhandled sense code
[  197.732807] sd 6:0:0:0: [sdb]
[  197.732810] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[  197.732812] sd 6:0:0:0: [sdb]
[  197.732815] Sense Key : Medium Error [current]
[  197.732819] sd 6:0:0:0: [sdb]
[  197.732822] Add. Sense: Unrecovered read error
[  197.732825] sd 6:0:0:0: [sdb] CDB:
[  197.732827] Read(10): 28 00 00 00 00 00 00 00 08 00
[  197.732839] end_request: critical target error, dev sdb, sector 0
[  197.733830] Buffer I/O error on device sdb, logical block 0
[  200.740099] sd 6:0:0:0: [sdb] Unhandled sense code
[  200.740106] sd 6:0:0:0: [sdb]
[  200.740109] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[  200.740112] sd 6:0:0:0: [sdb]
[  200.740114] Sense Key : Medium Error [current]
[  200.740118] sd 6:0:0:0: [sdb]
[  200.740121] Add. Sense: Unrecovered read error
[  200.740124] sd 6:0:0:0: [sdb] CDB:
[  200.740126] Read(10): 28 00 00 00 00 00 00 00 08 00
[  200.740137] end_request: critical target error, dev sdb, sector 0
[  200.741394] Buffer I/O error on device sdb, logical block 0
[  203.751384] sd 6:0:0:0: [sdb] Unhandled sense code
[  203.751390] sd 6:0:0:0: [sdb]
[  203.751393] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[  203.751395] sd 6:0:0:0: [sdb]
[  203.751397] Sense Key : Medium Error [current]
[  203.751401] sd 6:0:0:0: [sdb]
[  203.751404] Add. Sense: Unrecovered read error
[  203.751407] sd 6:0:0:0: [sdb] CDB:
[  203.751409] Read(10): 28 00 00 00 00 00 00 00 08 00
[  203.751420] end_request: critical target error, dev sdb, sector 0
[  203.752412] Buffer I/O error on device sdb, logical block 0

What is interesting - on another box, Linux (3.9.6) survives card insertion:

[ 2446.960993] sd 8:0:0:0: [sdc] 3862528 512-byte logical blocks:
(1.97 GB/1.84 GiB)
[ 2446.963237] sd 8:0:0:0: [sdc] No Caching mode page present
[ 2446.963245] sd 8:0:0:0: [sdc] Assuming drive cache: write through
[ 2446.966369] sd 8:0:0:0: [sdc] No Caching mode page present
[ 2446.966377] sd 8:0:0:0: [sdc] Assuming drive cache: write through
[ 2446.982859]  sdc: sdc1
[ 2448.463726] sd 8:0:0:0: [sdc] Device not ready
[ 2448.463737] sd 8:0:0:0: [sdc]
[ 2448.463742] Result: hostbyte=0x00 driverbyte=0x08
[ 2448.463748] sd 8:0:0:0: [sdc]
[ 2448.463752] Sense Key : 0x2 [current]
[ 2448.463765] Info fld=0x0
[ 2448.463769] sd 8:0:0:0: [sdc]
[ 2448.463773] <<vendor>> ASC=0xff ASCQ=0xffASC=0xff <<vendor>> ASCQ=0xff
[ 2448.463783] sd 8:0:0:0: [sdc] CDB:
[ 2448.463787] cdb[0]=0x28: 28 00 00 00 03 ff 00 00 08 00
[ 2448.463853] end_request: I/O error, dev sdc, sector 1023
[ 2448.463859] Buffer I/O error on device sdc1, logical block 888
[ 2448.463864] Buffer I/O error on device sdc1, logical block 889
[ 2448.463869] Buffer I/O error on device sdc1, logical block 890
[ 2448.463873] Buffer I/O error on device sdc1, logical block 891
[ 2448.463878] Buffer I/O error on device sdc1, logical block 892
[ 2448.463883] Buffer I/O error on device sdc1, logical block 893
[ 2448.463888] Buffer I/O error on device sdc1, logical block 894
[ 2448.463892] Buffer I/O error on device sdc1, logical block 895
[ 2449.491503] sd 8:0:0:0: [sdc] Device not ready
[ 2449.491512] sd 8:0:0:0: [sdc]
[ 2449.491517] Result: hostbyte=0x00 driverbyte=0x08
[ 2449.491522] sd 8:0:0:0: [sdc]
[ 2449.491526] Sense Key : 0x2 [current]
[ 2449.491538] Info fld=0x0
[ 2449.491543] sd 8:0:0:0: [sdc]
[ 2449.491547] <<vendor>> ASC=0xff ASCQ=0xffASC=0xff <<vendor>> ASCQ=0xff
[ 2449.491556] sd 8:0:0:0: [sdc] CDB:
[ 2449.491559] cdb[0]=0x28: 28 00 00 00 04 01 00 00 06 00
[ 2449.491587] end_request: I/O error, dev sdc, sector 1025
[ 2449.491592] Buffer I/O error on device sdc1, logical block 890
[ 2449.491598] Buffer I/O error on device sdc1, logical block 891
[ 2500.907374] sdc: detected capacity change from 1977614336 to 0

If you want me to test some patches, just shout ;)

Marcin

--089e013a2d8668d70304e20d8704
Content-Type: application/octet-stream;
	name="sg_complete_io_dev_crash_fix.patch"
Content-Disposition: attachment;
	filename="sg_complete_io_dev_crash_fix.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hjesnwyg0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2NvcmUvbWVzc2FnZS5jIGIvZHJpdmVycy91c2IvY29y
ZS9tZXNzYWdlLmMKaW5kZXggNDQ0ZDMwZS4uZWU0NjJhMCAxMDA2NDQKLS0tIGEvZHJpdmVycy91
c2IvY29yZS9tZXNzYWdlLmMKKysrIGIvZHJpdmVycy91c2IvY29yZS9tZXNzYWdlLmMKQEAgLTI4
MCw5ICsyODAsOSBAQCBzdGF0aWMgdm9pZCBzZ19jb21wbGV0ZShzdHJ1Y3QgdXJiICp1cmIpCiAJ
CQkmJiAoaW8tPnN0YXR1cyAhPSAtRUNPTk5SRVNFVAogCQkJCXx8IHN0YXR1cyAhPSAtRUNPTk5S
RVNFVCkKIAkJCSYmIHVyYi0+YWN0dWFsX2xlbmd0aCkgewotCQlkZXZfZXJyKGlvLT5kZXYtPmJ1
cy0+Y29udHJvbGxlciwKKwkJZGV2X2Vycihpby0+ZGV2ID8gaW8tPmRldi0+YnVzLT5jb250cm9s
bGVyIDogTlVMTCwKIAkJCSJkZXYgJXMgZXAlZCVzIHNjYXR0ZXJsaXN0IGVycm9yICVkLyVkXG4i
LAotCQkJaW8tPmRldi0+ZGV2cGF0aCwKKwkJCWlvLT5kZXYgPyBpby0+ZGV2LT5kZXZwYXRoIDog
Ij8/PyIsCiAJCQl1c2JfZW5kcG9pbnRfbnVtKCZ1cmItPmVwLT5kZXNjKSwKIAkJCXVzYl91cmJf
ZGlyX2luKHVyYikgPyAiaW4iIDogIm91dCIsCiAJCQlzdGF0dXMsIGlvLT5zdGF0dXMpOwo=
--089e013a2d8668d70304e20d8704--
