From: Jevgeni Tverdohlebov <tugevus@gmail.com>
Subject: Re: Fwd: [Bug 1066375] Re: 1180:0822 smart card reader Ricoh Co Ltd
 RL5c476 II not working
Date: Sat, 03 Nov 2012 00:13:04 +0200
Message-ID: <50944570.5090705@gmail.com>
References: <20121028232517.3198.16139.malone@chaenomeles.canonical.com> <508F8473.3010704@gmail.com> <509443E4.7020104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:44819 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199Ab2KBWNI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Nov 2012 18:13:08 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so2941394lbo.19
        for <linux-mmc@vger.kernel.org>; Fri, 02 Nov 2012 15:13:06 -0700 (PDT)
In-Reply-To: <509443E4.7020104@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Bug 1066375 <1066375@bugs.launchpad.net>


> Hello,
>
> Please find the problem report below.
>
> Regards,
>
>
> jevgtv
>
> On 30.10.2012 09:40, Jevgeni Tverdohlebov wrote:
>> [1.] 1180:0822 smart card reader Ricoh Co Ltd RL5c476 II not working
>> [2.] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1066375
>> [3.] natty 
>> <https://bugs.launchpad.net/ubuntu/+source/linux/+bugs?field.tag=natty> 
>> precise 
>> <https://bugs.launchpad.net/ubuntu/+source/linux/+bugs?field.tag=precise> 
>> apport-collected 
>> <https://bugs.launchpad.net/ubuntu/+source/linux/+bugs?field.tag=apport-collected> 
>> kernel-bug-exists-upstream 
>> <https://bugs.launchpad.net/ubuntu/+source/linux/+bugs?field.tag=kernel-bug-exists-upstream> 
>> kernel-bug-exists-upstream-v3.7-rc1-quantal 
>> <https://bugs.launchpad.net/ubuntu/+source/linux/+bugs?field.tag=kernel-bug-exists-upstream-v3.7-rc1-quantal> 
>> kernel-media 
>> <https://bugs.launchpad.net/ubuntu/+source/linux/+bugs?field.tag=kernel-media> 
>> kernel-unable-to-test-upstream-v3.7-rc2-quantal 
>> <https://bugs.launchpad.net/ubuntu/+source/linux/+bugs?field.tag=kernel-unable-to-test-upstream-v3.7-rc2-quantal> 
>> laptop-testing 
>> <https://bugs.launchpad.net/ubuntu/+source/linux/+bugs?field.tag=laptop-testing> 
>> lucid 
>> <https://bugs.launchpad.net/ubuntu/+source/linux/+bugs?field.tag=lucid> 
>> running-unity 
>> <https://bugs.launchpad.net/ubuntu/+source/linux/+bugs?field.tag=running-unity>
>> [4.] cat /proc/version
>> Linux version 3.3.7-030307-generic (apw@gomeisa) (gcc version 4.4.3 
>> (Ubuntu 4.4.3-4ubuntu5.1) ) #201205211535 SMP Mon May 21 19:42:58 UTC 
>> 2012
>> [5.]
>>
>> Locale (time-, number format / codepage): English / en_US.UTF-8
>>
>> Base version: 3.6.0.904-ubuntu-12-04
>> ID-card utility version: 3.6.0.694-ubuntu-12-04
>> OS: Ubuntu Precise Pangolin 12.04
>> CPU: model name : Intel(R) Core(TM)2 Duo CPU T7100 @ 1.80GHz
>> Kernel: Linux 3.3.7-030307-generic #201205211535 SMP Mon May 21 
>> 19:42:58 UTC 2012 i686
>>
>> Library paths: /usr/lib/i386-linux-gnu/qt4/plugins;/usr/bin
>> Libraries:
>> libdigidoc (3.6.0.707-ubuntu-12-04)
>> libdigidocpp (3.6.0.771-ubuntu-12-04)
>> qdigidoc (3.6.0.795-ubuntu-12-04)
>> qesteidutil (3.6.0.694-ubuntu-12-04)
>> openssl (1.0.1-4ubuntu5.5)
>> libpcsclite1 (1.7.4-2ubuntu2)
>> opensc (0.12.2-2ubuntu1)
>> QT (4.8.1)
>>
>> PCSC service status: Running
>>
>> Card readers:
>>
>> No readers found
>>
>>
>> Browsers:
>> chromium-browser ()
>> firefox (16.0.1+build1-0ubuntu0.12.04.1)
>>
>> OpenSC tool:
>> No smart card readers found.
>>
>> PKCS11 tool:
>> Available slots:
>>
>> USB info:
>> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
>> Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
>> Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
>> Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
>> Bus 005 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
>> Bus 006 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
>> Bus 007 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
>> Bus 005 Device 002: ID 08ff:2580 AuthenTec, Inc. AES2501 Fingerprint 
>> Sensor
>>
>> [6.]  It is possible to downlowd the software does not work with the 
>> reader from installer.id.ee
>> [7.] Ubuntu Precise Pangolin 12.04
>> [7.1.] /usr/src/linux-headers-3.3.7-030307/scripts/ver_linux
>> If some fields are empty or look unusual you may have an old version.
>> Compare to the current minimal requirements in Documentation/Changes.
>>
>> Linux jevgtv-HP-Compaq-6910p 3.3.7-030307-generic #201205211535 SMP 
>> Mon May 21 19:42:58 UTC 2012 i686 i686 i386 GNU/Linux
>>
>> Gnu C                  4.6
>> Gnu make               3.81
>> binutils               2.22
>> util-linux             2.20.1
>> mount                  support
>> module-init-tools      3.16
>> e2fsprogs              1.42
>> pcmciautils            018
>> PPP                    2.4.5
>> Linux C Library        2.15
>> Dynamic linker (ldd)   2.15
>> Procps                 3.2.8
>> Net-tools              1.60
>> Kbd                    1.15.2
>> Sh-utils               8.13
>> wireless-tools         30
>> Modules Loaded         bnep rfcomm bluetooth binfmt_misc ip6t_LOG 
>> xt_hl ip6t_rt nf_conntrack_ipv6 nf_defrag_ipv6 ipt_REJECT ipt_LOG 
>> xt_limit xt_tcpudp xt_addrtype dm_crypt xt_state ip6table_filter 
>> snd_hda_codec_analog pata_pcmcia snd_hda_intel snd_hda_codec 
>> snd_hwdep tpm_infineon snd_pcm ip6_tables snd_seq_midi 
>> nf_conntrack_netbios_ns nf_conntrack_broadcast snd_rawmidi 
>> snd_seq_midi_event nf_nat_ftp nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 
>> arc4 snd_seq nf_conntrack_ftp nf_conntrack iwl4965 iwlegacy snd_timer 
>> iptable_filter snd_seq_device ip_tables mac80211 pcmcia snd soundcore 
>> snd_page_alloc irda yenta_socket pcmcia_rsrc pcmcia_core ppdev joydev 
>> x_tables cfg80211 psmouse hp_wmi sparse_keymap parport_pc tpm_tis 
>> crc_ccitt hp_accel lis3lv02d serio_raw mac_hid input_polldev lp 
>> parport firewire_ohci firewire_core sdhci_pci sdhci crc_itu_t i915 
>> e1000e drm_kms_helper drm i2c_algo_bit video wmi
>>
>> [7.2.] cat /proc/cpuinfo
>> processor    : 0
>> vendor_id    : GenuineIntel
>> cpu family    : 6
>> model        : 15
>> model name    : Intel(R) Core(TM)2 Duo CPU     T7100  @ 1.80GHz
>> stepping    : 13
>> microcode    : 0xa1
>> cpu MHz        : 800.000
>> cache size    : 2048 KB
>> physical id    : 0
>> siblings    : 2
>> core id        : 0
>> cpu cores    : 2
>> apicid        : 0
>> initial apicid    : 0
>> fdiv_bug    : no
>> hlt_bug        : no
>> f00f_bug    : no
>> coma_bug    : no
>> fpu        : yes
>> fpu_exception    : yes
>> cpuid level    : 10
>> wp        : yes
>> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
>> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx 
>> lm constant_tsc arch_perfmon pebs bts aperfmperf pni dtes64 monitor 
>> ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm lahf_lm ida dts tpr_shadow 
>> vnmi flexpriority
>> bogomips    : 3591.29
>> clflush size    : 64
>> cache_alignment    : 64
>> address sizes    : 36 bits physical, 48 bits virtual
>> power management:
>>
>> processor    : 1
>> vendor_id    : GenuineIntel
>> cpu family    : 6
>> model        : 15
>> model name    : Intel(R) Core(TM)2 Duo CPU     T7100  @ 1.80GHz
>> stepping    : 13
>> microcode    : 0xa1
>> cpu MHz        : 800.000
>> cache size    : 2048 KB
>> physical id    : 0
>> siblings    : 2
>> core id        : 1
>> cpu cores    : 2
>> apicid        : 1
>> initial apicid    : 1
>> fdiv_bug    : no
>> hlt_bug        : no
>> f00f_bug    : no
>> coma_bug    : no
>> fpu        : yes
>> fpu_exception    : yes
>> cpuid level    : 10
>> wp        : yes
>> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
>> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx 
>> lm constant_tsc arch_perfmon pebs bts aperfmperf pni dtes64 monitor 
>> ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm lahf_lm ida dts tpr_shadow 
>> vnmi flexpriority
>> bogomips    : 3591.29
>> clflush size    : 64
>> cache_alignment    : 64
>> address sizes    : 36 bits physical, 48 bits virtual
>> power management:
>>
>> [7.3.] cat /proc/modules
>> bnep 17749 2 - Live 0x00000000
>> rfcomm 37611 0 - Live 0x00000000
>> bluetooth 166358 10 bnep,rfcomm, Live 0x00000000
>> binfmt_misc 17258 1 - Live 0x00000000
>> ip6t_LOG 16874 4 - Live 0x00000000
>> xt_hl 12465 6 - Live 0x00000000
>> ip6t_rt 12473 3 - Live 0x00000000
>> nf_conntrack_ipv6 13567 7 - Live 0x00000000
>> nf_defrag_ipv6 13073 1 nf_conntrack_ipv6, Live 0x00000000
>> ipt_REJECT 12512 1 - Live 0x00000000
>> ipt_LOG 12811 5 - Live 0x00000000
>> xt_limit 12570 12 - Live 0x00000000
>> xt_tcpudp 12531 18 - Live 0x00000000
>> xt_addrtype 12563 4 - Live 0x00000000
>> dm_crypt 22384 1 - Live 0x00000000
>> xt_state 12514 14 - Live 0x00000000
>> ip6table_filter 12711 1 - Live 0x00000000
>> snd_hda_codec_analog 75306 1 - Live 0x00000000
>> pata_pcmcia 16938 1 - Live 0x00000000
>> snd_hda_intel 32396 2 - Live 0x00000000
>> snd_hda_codec 108912 2 snd_hda_codec_analog,snd_hda_intel, Live 
>> 0x00000000
>> snd_hwdep 13272 1 snd_hda_codec, Live 0x00000000
>> tpm_infineon 17187 0 - Live 0x00000000
>> snd_pcm 76379 2 snd_hda_intel,snd_hda_codec, Live 0x00000000
>> ip6_tables 18332 3 ip6t_LOG,ip6t_rt,ip6table_filter, Live 0x00000000
>> snd_seq_midi 13132 0 - Live 0x00000000
>> nf_conntrack_netbios_ns 12585 0 - Live 0x00000000
>> nf_conntrack_broadcast 12541 1 nf_conntrack_netbios_ns, Live 0x00000000
>> snd_rawmidi 25371 1 snd_seq_midi, Live 0x00000000
>> snd_seq_midi_event 14475 1 snd_seq_midi, Live 0x00000000
>> nf_nat_ftp 12548 0 - Live 0x00000000
>> nf_nat 20351 1 nf_nat_ftp, Live 0x00000000
>> nf_conntrack_ipv4 18980 9 nf_nat, Live 0x00000000
>> nf_defrag_ipv4 12649 1 nf_conntrack_ipv4, Live 0x00000000
>> arc4 12473 2 - Live 0x00000000
>> snd_seq 51256 2 snd_seq_midi,snd_seq_midi_event, Live 0x00000000
>> nf_conntrack_ftp 13081 1 nf_nat_ftp, Live 0x00000000
>> nf_conntrack 69327 8 
>> nf_conntrack_ipv6,xt_state,nf_conntrack_netbios_ns,nf_conntrack_broadcast,nf_nat_ftp,nf_nat,nf_conntrack_ipv4,nf_conntrack_ftp, 
>> Live 0x00000000
>> iwl4965 95468 0 - Live 0x00000000
>> iwlegacy 64266 1 iwl4965, Live 0x00000000
>> snd_timer 24609 2 snd_pcm,snd_seq, Live 0x00000000
>> iptable_filter 12706 1 - Live 0x00000000
>> snd_seq_device 14130 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x00000000
>> ip_tables 18008 1 iptable_filter, Live 0x00000000
>> mac80211 435875 2 iwl4965,iwlegacy, Live 0x00000000
>> pcmcia 39606 1 pata_pcmcia, Live 0x00000000
>> snd 61792 13 
>> snd_hda_codec_analog,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_timer,snd_seq_device, 
>> Live 0x00000000
>> soundcore 14556 1 snd, Live 0x00000000
>> snd_page_alloc 14036 2 snd_hda_intel,snd_pcm, Live 0x00000000
>> irda 181321 0 - Live 0x00000000
>> yenta_socket 27140 0 - Live 0x00000000
>> pcmcia_rsrc 18292 1 yenta_socket, Live 0x00000000
>> pcmcia_core 21505 3 pcmcia,yenta_socket,pcmcia_rsrc, Live 0x00000000
>> ppdev 12900 0 - Live 0x00000000
>> joydev 17313 0 - Live 0x00000000
>> x_tables 21895 13 
>> ip6t_LOG,xt_hl,ip6t_rt,ipt_REJECT,ipt_LOG,xt_limit,xt_tcpudp,xt_addrtype,xt_state,ip6table_filter,ip6_tables,iptable_filter,ip_tables, 
>> Live 0x00000000
>> cfg80211 178943 3 iwl4965,iwlegacy,mac80211, Live 0x00000000
>> psmouse 86921 0 - Live 0x00000000
>> hp_wmi 13652 0 - Live 0x00000000
>> sparse_keymap 13658 1 hp_wmi, Live 0x00000000
>> parport_pc 32006 1 - Live 0x00000000
>> tpm_tis 18198 0 - Live 0x00000000
>> crc_ccitt 12595 1 irda, Live 0x00000000
>> hp_accel 25728 0 - Live 0x00000000
>> lis3lv02d 19262 1 hp_accel, Live 0x00000000
>> serio_raw 13027 0 - Live 0x00000000
>> mac_hid 13037 0 - Live 0x00000000
>> input_polldev 13648 1 lis3lv02d, Live 0x00000000
>> lp 13349 0 - Live 0x00000000
>> parport 36664 3 ppdev,parport_pc,lp, Live 0x00000000
>> firewire_ohci 39598 0 - Live 0x00000000
>> firewire_core 56758 1 firewire_ohci, Live 0x00000000
>> sdhci_pci 18131 0 - Live 0x00000000
>> sdhci 31783 1 sdhci_pci, Live 0x00000000
>> crc_itu_t 12627 1 firewire_core, Live 0x00000000
>> i915 417396 2 - Live 0x00000000
>> e1000e 138056 0 - Live 0x00000000
>> drm_kms_helper 41027 1 i915, Live 0x00000000
>> drm 212983 3 i915,drm_kms_helper, Live 0x00000000
>> i2c_algo_bit 13152 1 i915, Live 0x00000000
>> video 18792 1 i915, Live 0x00000000
>> wmi 18645 1 hp_wmi, Live 0x00000000
>>
>> [7.4.] cat /proc/ioports
>> 0000-001f : dma1
>> 0020-0021 : pic1
>> 0040-0043 : timer0
>> 0050-0053 : timer1
>> 0060-0060 : keyboard
>> 0062-0062 : EC data
>> 0064-0064 : keyboard
>> 0066-0066 : EC cmd
>> 0070-0071 : rtc0
>> 0080-008f : dma page reg
>> 00a0-00a1 : pic2
>> 00c0-00df : dma2
>> 00f0-00ff : fpu
>> 0170-0177 : 0000:00:1f.2
>>   0170-0177 : ata_piix
>> 01f0-01f7 : 0000:00:1f.2
>>   01f0-01f7 : ata_piix
>> 0376-0376 : 0000:00:1f.2
>>   0376-0376 : ata_piix
>> 0378-037a : parport0
>> 03e8-03ef : serial
>> 03f6-03f6 : 0000:00:1f.2
>>   03f6-03f6 : ata_piix
>> 04d0-04d1 : pnp 00:0e
>> 0500-055f : pnp 00:0c
>> 0778-077a : parport0
>> 0800-080f : pnp 00:0c
>> 0cf8-0cff : PCI conf1
>> 1000-107f : 0000:00:1f.0
>>   1000-107f : pnp 00:0e
>>     1000-1003 : ACPI PM1a_EVT_BLK
>>     1004-1005 : ACPI PM1a_CNT_BLK
>>     1008-100b : ACPI PM_TMR
>>     1010-1015 : ACPI CPU throttle
>>     1020-1020 : ACPI PM2_CNT_BLK
>>     1028-102f : ACPI GPE0_BLK
>> 1100-113f : 0000:00:1f.0
>>   1100-113f : pnp 00:0e
>> 1200-121f : pnp 00:0e
>> 15f0-15ff : 0000:00:1f.2
>> 2000-3fff : PCI Bus 0000:28
>> 4000-4007 : 0000:00:02.0
>> 4020-403f : 0000:00:19.0
>> 4040-405f : 0000:00:1a.0
>>   4040-405f : uhci_hcd
>> 4060-407f : 0000:00:1a.1
>>   4060-407f : uhci_hcd
>> 4080-409f : 0000:00:1d.0
>>   4080-409f : uhci_hcd
>> 40a0-40bf : 0000:00:1d.1
>>   40a0-40bf : uhci_hcd
>> 40c0-40df : 0000:00:1d.2
>>   40c0-40df : uhci_hcd
>> 40e0-40ef : 0000:00:1f.2
>>   40e0-40ef : ata_piix
>> 5000-5fff : PCI Bus 0000:02
>>   5000-50ff : PCI CardBus 0000:04
>>   5100-510f : pcmcia_socket1
>>     5100-510f : pcmcia1.0
>>   5400-54ff : PCI CardBus 0000:04
>>   5800-58ff : PCI CardBus 0000:03
>>   5c00-5cff : PCI CardBus 0000:03
>>
>> cat /proc/iomem
>> 00000000-0000ffff : reserved
>> 00010000-0009fbff : System RAM
>> 0009fc00-0009ffff : reserved
>> 000a0000-000bffff : Video RAM area
>> 000c0000-000c7fff : Video ROM
>> 000cee00-000cffff : pnp 00:0f
>> 000d0000-000d0fff : Adapter ROM
>> 000d1000-000d1fff : Adapter ROM
>> 000d2000-000d3fff : pnp 00:0f
>> 000e0000-000fffff : reserved
>>   000f0000-000fffff : System ROM
>> 00100000-7f7affff : System RAM
>>   01000000-0157b378 : Kernel code
>>   0157b379-01829bbf : Kernel data
>>   018e2000-019b9fff : Kernel bss
>> 7f7b0000-7f7c53ff : reserved
>> 7f7c5400-7f7e7fb7 : ACPI Non-volatile Storage
>> 7f7e7fb8-7fffffff : reserved
>> 80000000-87ffffff : PCI Bus 0000:02
>>   80000000-83ffffff : PCI CardBus 0000:04
>>   84000000-87ffffff : PCI CardBus 0000:03
>> 88000000-881fffff : PCI Bus 0000:28
>> 88200000-88200fff : Intel Flush Page
>> 8c000000-8fffffff : PCI CardBus 0000:04
>> 90000000-93ffffff : PCI CardBus 0000:03
>> d0000000-dfffffff : 0000:00:02.0
>> e0000000-e3ffffff : PCI Bus 0000:28
>> e4000000-e40fffff : PCI Bus 0000:10
>>   e4000000-e4001fff : 0000:10:00.0
>>     e4000000-e4001fff : iwl4965
>> e4100000-e43fffff : PCI Bus 0000:02
>>   e4100000-e4100fff : 0000:02:06.0
>>     e4100000-e4100fff : yenta_socket
>>   e4101000-e4101fff : 0000:02:06.1
>>     e4101000-e4101fff : yenta_socket
>>   e4102000-e41027ff : 0000:02:06.2
>>     e4102000-e41027ff : firewire_ohci
>>   e4103000-e41030ff : 0000:02:06.3
>>     e4103000-e41030ff : mmc0
>>   e4130000-e4130fff : pcmcia_socket1
>> e4400000-e44fffff : 0000:00:02.0
>> e4500000-e45fffff : 0000:00:02.1
>> e4600000-e461ffff : 0000:00:19.0
>>   e4600000-e461ffff : e1000e
>> e4620000-e4620fff : 0000:00:19.0
>>   e4620000-e4620fff : e1000e
>> e4621000-e46213ff : 0000:00:1a.7
>>   e4621000-e46213ff : ehci_hcd
>> e4624000-e4627fff : 0000:00:1b.0
>>   e4624000-e4627fff : ICH HD audio
>> e4628000-e46283ff : 0000:00:1d.7
>>   e4628000-e46283ff : ehci_hcd
>> f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
>>   f8000000-fbffffff : pnp 00:0e
>> fec00000-fec00fff : reserved
>>   fec00000-fec003ff : IOAPIC 0
>> fed00000-fed003ff : HPET 0
>> fed20000-fed99fff : reserved
>>   fed20000-fed3ffff : pnp 00:0e
>>   fed45000-fed8ffff : pnp 00:0e
>>   fed90000-fed99fff : pnp 00:0e
>> feda0000-fedbffff : reserved
>>   feda0000-fedbffff : pnp 00:0f
>> fee00000-fee00fff : Local APIC
>>   fee00000-fee00fff : reserved
>>     fee00000-fee00fff : pnp 00:0f
>> ffb00000-ffbfffff : reserved
>>   ffb00000-ffbfffff : pnp 00:0c
>> fff00000-ffffffff : reserved
>>   fff00000-ffffffff : pnp 00:0c
>>
>> [7.5.]         Address: 00000000fee0200c  Data: 41b9
>>     Kernel driver in use: e1000e
>>     Kernel modules: e1000e
>>
>> 00:1a.0 USB controller: Intel Corporation 82801H (ICH8 Family) USB 
>> UHCI Controller #4 (rev 03) (prog-if 00 [UHCI])
>>     Subsystem: Hewlett-Packard Company Device 30be
>>     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>> ParErr- Stepping- SERR- FastB2B- DisINTx-
>>     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>     Latency: 0
>>     Interrupt: pin A routed to IRQ 16
>>     Region 4: I/O ports at 4040 [size=32]
>>     Kernel driver in use: uhci_hcd
>>
>> 00:1a.1 USB controller: Intel Corporation 82801H (ICH8 Family) USB 
>> UHCI Controller #5 (rev 03) (prog-if 00 [UHCI])
>>     Subsystem: Hewlett-Packard Company Device 30be
>>     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>> ParErr- Stepping- SERR- FastB2B- DisINTx-
>>     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>     Latency: 0
>>     Interrupt: pin B routed to IRQ 17
>>     Region 4: I/O ports at 4060 [size=32]
>>     Kernel driver in use: uhci_hcd
>>
>> 00:1a.7 USB controller: Intel Corporation 82801H (ICH8 Family) USB2 
>> EHCI Controller #2 (rev 03) (prog-if 20 [EHCI])
>>     Subsystem: Hewlett-Packard Company Device 30be
>>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>> ParErr- Stepping- SERR- FastB2B- DisINTx-
>>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>     Latency: 0
>>     Interrupt: pin C routed to IRQ 18
>>     Region 0: Memory at e4621000 (32-bit, non-prefetchable) [size=1K]
>>     Capabilities: [50] Power Management version 2
>>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
>> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>     Capabilities: [58] Debug port: BAR=1 offset=00a0
>>     Kernel driver in use: ehci_hcd
>>
>> 00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio 
>> Controller (rev 03)
>>     Subsystem: Hewlett-Packard Company Device 30be
>>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>> ParErr- Stepping- SERR- FastB2B- DisINTx+
>>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>     Latency: 0, Cache Line Size: 64 bytes
>>     Interrupt: pin A routed to IRQ 46
>>     Region 0: Memory at e4624000 (64-bit, non-prefetchable) [size=16K]
>>     Capabilities: [50] Power Management version 2
>>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA 
>> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>     Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
>>         Address: 00000000fee0300c  Data: 41a9
>>     Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, 
>> MSI 00
>>         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
>> unlimited, L1 unlimited
>>             ExtTag- RBE- FLReset-
>>         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
>> Unsupported-
>>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
>>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>>         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
>> TransPend-
>>         LnkCap:    Port #0, Speed unknown, Width x0, ASPM unknown, 
>> Latency L0 <64ns, L1 <1us
>>             ClockPM- Surprise- LLActRep- BwNot-
>>         LnkCtl:    ASPM Disabled; Disabled- Retrain- CommClk-
>>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>         LnkSta:    Speed unknown, Width x0, TrErr- Train- SlotClk- 
>> DLActive- BWMgmt- ABWMgmt-
>>     Capabilities: [100 v1] Virtual Channel
>>         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
>>         Arb:    Fixed- WRR32- WRR64- WRR128-
>>         Ctrl:    ArbSelect=Fixed
>>         Status:    InProgress-
>>         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>>             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>>             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
>>             Status:    NegoPending- InProgress-
>>         VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>>             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>>             Ctrl:    Enable+ ID=1 ArbSelect=Fixed TC/VC=80
>>             Status:    NegoPending- InProgress-
>>     Capabilities: [130 v1] Root Complex Link
>>         Desc:    PortNumber=0f ComponentID=02 EltType=Config
>>         Link0:    Desc:    TargetPort=00 TargetComponent=02 
>> AssocRCRB- LinkType=MemMapped LinkValid+
>>             Addr:    00000000fed90000
>>     Kernel driver in use: snd_hda_intel
>>     Kernel modules: snd-hda-intel
>>
>> 00:1c.0 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI 
>> Express Port 1 (rev 03) (prog-if 00 [Normal decode])
>>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>> ParErr- Stepping- SERR- FastB2B- DisINTx+
>>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>     Latency: 0, Cache Line Size: 64 bytes
>>     Bus: primary=00, secondary=08, subordinate=08, sec-latency=0
>>     I/O behind bridge: 0000f000-00000fff
>>     Memory behind bridge: fff00000-000fffff
>>     Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
>>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
>> <TAbort- <MAbort+ <SERR- <PERR-
>>     BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
>>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>>     Capabilities: [40] Express (v1) Root Port (Slot-), MSI 00
>>         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
>> unlimited, L1 unlimited
>>             ExtTag- RBE+ FLReset-
>>         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
>> Unsupported-
>>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>>         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
>> TransPend-
>>         LnkCap:    Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, 
>> Latency L0 <1us, L1 <4us
>>             ClockPM- Surprise- LLActRep+ BwNot-
>>         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- 
>> CommClk-
>>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>         LnkSta:    Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ 
>> DLActive- BWMgmt- ABWMgmt-
>>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ 
>> CRSVisible-
>>         RootCap: CRSVisible-
>>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>>     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>>         Address: fee0300c  Data: 4171
>>     Capabilities: [90] Subsystem: Hewlett-Packard Company Device 30be
>>     Capabilities: [a0] Power Management version 2
>>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
>> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>     Capabilities: [100 v1] Virtual Channel
>>         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
>>         Arb:    Fixed+ WRR32- WRR64- WRR128-
>>         Ctrl:    ArbSelect=Fixed
>>         Status:    InProgress-
>>         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>>             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
>>             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
>>             Status:    NegoPending- InProgress-
>>     Capabilities: [180 v1] Root Complex Link
>>         Desc:    PortNumber=01 ComponentID=02 EltType=Config
>>         Link0:    Desc:    TargetPort=00 TargetComponent=02 
>> AssocRCRB- LinkType=MemMapped LinkValid+
>>             Addr:    00000000fed90001
>>     Kernel driver in use: pcieport
>>     Kernel modules: shpchp
>>
>> 00:1c.1 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI 
>> Express Port 2 (rev 03) (prog-if 00 [Normal decode])
>>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>> ParErr- Stepping- SERR- FastB2B- DisINTx+
>>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>     Latency: 0, Cache Line Size: 64 bytes
>>     Bus: primary=00, secondary=10, subordinate=10, sec-latency=0
>>     I/O behind bridge: 0000f000-00000fff
>>     Memory behind bridge: e4000000-e40fffff
>>     Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
>>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
>> <TAbort- <MAbort- <SERR- <PERR-
>>     BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
>>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>>     Capabilities: [40] Express (v1) Root Port (Slot-), MSI 00
>>         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
>> unlimited, L1 unlimited
>>             ExtTag- RBE+ FLReset-
>>         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
>> Unsupported-
>>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>>         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
>> TransPend-
>>         LnkCap:    Port #2, Speed 2.5GT/s, Width x1, ASPM L0s L1, 
>> Latency L0 <256ns, L1 <4us
>>             ClockPM- Surprise- LLActRep+ BwNot-
>>         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- 
>> CommClk+
>>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
>> DLActive+ BWMgmt- ABWMgmt-
>>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ 
>> CRSVisible-
>>         RootCap: CRSVisible-
>>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>>     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>>         Address: fee0300c  Data: 4179
>>     Capabilities: [90] Subsystem: Hewlett-Packard Company Device 30be
>>     Capabilities: [a0] Power Management version 2
>>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
>> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>     Capabilities: [100 v1] Virtual Channel
>>         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
>>         Arb:    Fixed+ WRR32- WRR64- WRR128-
>>         Ctrl:    ArbSelect=Fixed
>>         Status:    InProgress-
>>         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>>             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
>>             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
>>             Status:    NegoPending- InProgress-
>>     Capabilities: [180 v1] Root Complex Link
>>         Desc:    PortNumber=02 ComponentID=02 EltType=Config
>>         Link0:    Desc:    TargetPort=00 TargetComponent=02 
>> AssocRCRB- LinkType=MemMapped LinkValid+
>>             Addr:    00000000fed90001
>>     Kernel driver in use: pcieport
>>     Kernel modules: shpchp
>>
>> 00:1c.4 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI 
>> Express Port 5 (rev 03) (prog-if 00 [Normal decode])
>>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>> ParErr- Stepping- SERR- FastB2B- DisINTx+
>>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>     Latency: 0, Cache Line Size: 64 bytes
>>     Bus: primary=00, secondary=28, subordinate=28, sec-latency=0
>>     I/O behind bridge: 00002000-00003fff
>>     Memory behind bridge: e0000000-e3ffffff
>>     Prefetchable memory behind bridge: 0000000088000000-00000000881fffff
>>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
>> <TAbort- <MAbort- <SERR- <PERR-
>>     BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
>>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>>     Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
>>         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
>> unlimited, L1 unlimited
>>             ExtTag- RBE+ FLReset-
>>         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
>> Unsupported-
>>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>>         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
>> TransPend-
>>         LnkCap:    Port #5, Speed 2.5GT/s, Width x1, ASPM L0s L1, 
>> Latency L0 <1us, L1 <4us
>>             ClockPM- Surprise- LLActRep+ BwNot-
>>         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- 
>> CommClk-
>>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>         LnkSta:    Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ 
>> DLActive- BWMgmt- ABWMgmt-
>>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
>> Surprise+
>>             Slot #4, PowerLimit 0.160W; Interlock- NoCompl-
>>         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt+ 
>> HPIrq+ LinkChg-
>>             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- 
>> Interlock-
>>             Changed: MRL- PresDet- LinkState-
>>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ 
>> CRSVisible-
>>         RootCap: CRSVisible-
>>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>>     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>>         Address: fee0300c  Data: 4181
>>     Capabilities: [90] Subsystem: Hewlett-Packard Company Device 30be
>>     Capabilities: [a0] Power Management version 2
>>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
>> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>     Capabilities: [100 v1] Virtual Channel
>>         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
>>         Arb:    Fixed+ WRR32- WRR64- WRR128-
>>         Ctrl:    ArbSelect=Fixed
>>         Status:    InProgress-
>>         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>>             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
>>             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
>>             Status:    NegoPending- InProgress-
>>     Capabilities: [180 v1] Root Complex Link
>>         Desc:    PortNumber=05 ComponentID=02 EltType=Config
>>         Link0:    Desc:    TargetPort=00 TargetComponent=02 
>> AssocRCRB- LinkType=MemMapped LinkValid+
>>             Addr:    00000000fed90001
>>     Kernel driver in use: pcieport
>>     Kernel modules: shpchp
>>
>> 00:1d.0 USB controller: Intel Corporation 82801H (ICH8 Family) USB 
>> UHCI Controller #1 (rev 03) (prog-if 00 [UHCI])
>>     Subsystem: Hewlett-Packard Company Device 30be
>>     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>> ParErr- Stepping- SERR- FastB2B- DisINTx-
>>     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>     Latency: 0
>>     Interrupt: pin A routed to IRQ 20
>>     Region 4: I/O ports at 4080 [size=32]
>>     Kernel driver in use: uhci_hcd
>>
>> 00:1d.1 USB controller: Intel Corporation 82801H (ICH8 Family) USB 
>> UHCI Controller #2 (rev 03) (prog-if 00 [UHCI])
>>     Subsystem: Hewlett-Packard Company Device 30be
>>     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>> ParErr- Stepping- SERR- FastB2B- DisINTx-
>>     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>     Latency: 0
>>     Interrupt: pin B routed to IRQ 22
>>     Region 4: I/O ports at 40a0 [size=32]
>>     Kernel driver in use: uhci_hcd
>>
>> 00:1d.2 USB controller: Intel Corporation 82801H (ICH8 Family) USB 
>> UHCI Controller #3 (rev 03) (prog-if 00 [UHCI])
>>     Subsystem: Hewlett-Packard Company Device 30be
>>     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>> ParErr- Stepping- SERR- FastB2B- DisINTx-
>>     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>     Latency: 0
>>     Interrupt: pin C routed to IRQ 18
>>     Region 4: I/O ports at 40c0 [size=32]
>>     Kernel driver in use: uhci_hcd
>>
>> 00:1d.7 USB controller: Intel Corporation 82801H (ICH8 Family) USB2 
>> EHCI Controller #1 (rev 03) (prog-if 20 [EHCI])
>>     Subsystem: Hewlett-Packard Company Device 30be
>>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>> ParErr- Stepping- SERR- FastB2B- DisINTx-
>>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>     Latency: 0
>>     Interrupt: pin A routed to IRQ 20
>>     Region 0: Memory at e4628000 (32-bit, non-prefetchable) [size=1K]
>>     Capabilities: [50] Power Management version 2
>>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
>> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>     Capabilities: [58] Debug port: BAR=1 offset=00a0
>>     Kernel driver in use: ehci_hcd
>>
>> 00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 
>> f3) (prog-if 01 [Subtractive decode])
>>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>> ParErr- Stepping- SERR+ FastB2B- DisINTx-
>>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>     Latency: 0
>>     Bus: primary=00, secondary=02, subordinate=07, sec-latency=32
>>     I/O behind bridge: 00005000-00005fff
>>     Memory behind bridge: e4100000-e43fffff
>>     Prefetchable memory behind bridge: 0000000080000000-0000000087ffffff
>>     Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
>> <TAbort- <MAbort+ <SERR- <PERR-
>>     BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
>>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>>     Capabilities: [50] Subsystem: Hewlett-Packard Company Device 30be
>>
>> 00:1f.0 ISA bridge: Intel Corporation 82801HEM (ICH8M-E) LPC 
>> Interface Controller (rev 03)
>>     Subsystem: Hewlett-Packard Company Device 30be
>>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>> ParErr- Stepping- SERR- FastB2B- DisINTx-
>>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>     Latency: 0
>>     Capabilities: [e0] Vendor Specific Information: Len=0c <?>
>>     Kernel modules: iTCO_wdt
>>
>> 00:1f.2 IDE interface: Intel Corporation 82801HM/HEM (ICH8M/ICH8M-E) 
>> SATA Controller [IDE mode] (rev 03) (prog-if 80 [Master])
>>     Subsystem: Hewlett-Packard Company Device 30be
>>     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>> ParErr- Stepping- SERR- FastB2B- DisINTx-
>>     Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>     Latency: 0
>>     Interrupt: pin D routed to IRQ 21
>>     Region 0: I/O ports at 01f0 [size=8]
>>     Region 1: I/O ports at 03f4 [size=1]
>>     Region 2: I/O ports at 0170 [size=8]
>>     Region 3: I/O ports at 0374 [size=1]
>>     Region 4: I/O ports at 40e0 [size=16]
>>     Region 5: I/O ports at 15f0 [size=16]
>>     Capabilities: [70] Power Management version 3
>>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
>> PME(D0-,D1-,D2-,D3hot+,D3cold-)
>>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>>     Kernel driver in use: ata_piix
>>
>> 02:06.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev b9)
>>     Subsystem: Hewlett-Packard Company Device 30be
>>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>> ParErr- Stepping- SERR- FastB2B- DisINTx-
>>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>     Latency: 168
>>     Interrupt: pin A routed to IRQ 18
>>     Region 0: Memory at e4100000 (32-bit, non-prefetchable) [size=4K]
>>     Bus: primary=02, secondary=03, subordinate=03, sec-latency=176
>>     Memory window 0: 84000000-87fff000 (prefetchable)
>>     Memory window 1: 90000000-93fff000
>>     I/O window 0: 00005c00-00005cff
>>     I/O window 1: 00005800-000058ff
>>     BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
>>     16-bit legacy interface ports at 0001
>>     Kernel driver in use: yenta_cardbus
>>     Kernel modules: yenta_socket
>>
>> 02:06.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev b9)
>>     Subsystem: Hewlett-Packard Company Device 30be
>>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>> ParErr- Stepping- SERR- FastB2B- DisINTx-
>>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>     Latency: 168
>>     Interrupt: pin B routed to IRQ 19
>>     Region 0: Memory at e4101000 (32-bit, non-prefetchable) [size=4K]
>>     Bus: primary=02, secondary=04, subordinate=07, sec-latency=176
>>     Memory window 0: 80000000-83fff000 (prefetchable)
>>     Memory window 1: 8c000000-8ffff000
>>     I/O window 0: 00005400-000054ff
>>     I/O window 1: 00005000-000050ff
>>     BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
>>     16-bit legacy interface ports at 0001
>>     Kernel driver in use: yenta_cardbus
>>     Kernel modules: yenta_socket
>>
>> 02:06.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C832 IEEE 1394 
>> Controller (rev 03) (prog-if 10 [OHCI])
>>     Subsystem: Hewlett-Packard Company Device 30be
>>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>> ParErr- Stepping- SERR- FastB2B- DisINTx-
>>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>     Latency: 64 (500ns min, 1000ns max), Cache Line Size: 64 bytes
>>     Interrupt: pin C routed to IRQ 20
>>     Region 0: Memory at e4102000 (32-bit, non-prefetchable) [size=2K]
>>     Capabilities: [dc] Power Management version 2
>>         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
>> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=2 PME+
>>     Kernel driver in use: firewire_ohci
>>     Kernel modules: firewire-ohci
>>
>> 02:06.3 SD Host controller: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro 
>> Host Adapter (rev 20)
>>     Subsystem: Hewlett-Packard Company Device 30be
>>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>> ParErr- Stepping- SERR- FastB2B- DisINTx-
>>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>     Latency: 64, Cache Line Size: 64 bytes
>>     Interrupt: pin B routed to IRQ 19
>>     Region 0: Memory at e4103000 (32-bit, non-prefetchable) [size=256]
>>     Capabilities: [80] Power Management version 2
>>         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
>> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=2 PME-
>>     Kernel driver in use: sdhci-pci
>>     Kernel modules: sdhci-pci
>>
>> 10:00.0 Network controller: Intel Corporation PRO/Wireless 4965 AG or 
>> AGN [Kedron] Network Connection (rev 61)
>>     Subsystem: Intel Corporation Device 1001
>>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>> ParErr- Stepping- SERR- FastB2B- DisINTx-
>>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>     Latency: 0, Cache Line Size: 64 bytes
>>     Interrupt: pin A routed to IRQ 45
>>     Region 0: Memory at e4000000 (64-bit, non-prefetchable) [size=8K]
>>     Capabilities: [c8] Power Management version 3
>>         Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
>> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>     Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>>         Address: 00000000fee0100c  Data: 41a1
>>     Capabilities: [e0] Express (v1) Endpoint, MSI 00
>>         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
>> <512ns, L1 unlimited
>>             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>>         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
>> Unsupported-
>>             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>>         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
>> TransPend-
>>         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, 
>> Latency L0 <128ns, L1 <64us
>>             ClockPM+ Surprise- LLActRep- BwNot-
>>         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- 
>> CommClk+
>>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
>> DLActive- BWMgmt- ABWMgmt-
>>     Capabilities: [100 v1] Advanced Error Reporting
>>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
>> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
>> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>         UESvrt:    DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
>> RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>>         AERCap:    First Error Pointer: 00, GenCap- CGenEn- ChkCap- 
>> ChkEn-
>>
>> [7.6.] cat /proc/scsi/scsi
>> Attached devices:
>> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>>   Vendor: ATA      Model: HITACHI HTS54168 Rev: SB2I
>>   Type:   Direct-Access                    ANSI  SCSI revision: 05
>> Host: scsi1 Channel: 00 Id: 00 Lun: 00
>>   Vendor: MATSHITA Model: DVD-RAM UJ-852S  Rev: 1.02
>>   Type:   CD-ROM                           ANSI  SCSI revision: 05
>>
>> [7.7.] ls /proc
>> 1     1561  1863  1952  2507  48   958          interrupts scsi
>> 10    1573  1865  2     2552  585  974          iomem self
>> 1000  1575  1866  20    2587  595  988          ioports slabinfo
>> 1001  1579  1869  2001  2589  596  997          irq softirqs
>> 1006  16    1872  2009  26    6    999          kallsyms stat
>> 1013  1637  1873  2018  2605  643  acpi         kcore swaps
>> 1116  1662  1875  21    2609  646  asound       key-users sys
>> 12    17    1877  2174  27    659  buddyinfo    kmsg sysrq-trigger
>> 1222  1735  1878  2196  2739  676  bus          kpagecount sysvipc
>> 1234  18    1886  22    28    69   cgroups      kpageflags timer_list
>> 1243  1809  1888  2281  29    695  cmdline      latency_stats timer_stats
>> 1244  1812  1894  2284  2933  7    consoles     loadavg tty
>> 1246  1813  1897  23    2960  70   cpuinfo      locks uptime
>> 1259  1818  19    2318  2985  732  crypto       mdstat version
>> 1260  1823  1904  233   2990  735  devices      meminfo vmallocinfo
>> 1269  1831  1906  2330  3     792  device-tree  misc vmstat
>> 1270  1835  1908  2335  30    8    diskstats    modules zoneinfo
>> 1284  1837  1909  2378  302   802  dma          mounts
>> 13    1846  1912  2421  303   803  dri          mtrr
>> 1377  1848  1915  2440  31    894  driver       net
>> 1379  1851  1923  2443  368   895  execdomains  pagetypeinfo
>> 1391  1853  1946  2444  372   913  fb           partitions
>> 14    1855  1948  25    39    932  filesystems  sched_debug
>> 15    1859  1949  2500  47    935  fs           schedstat
>>
>>
>>
>>
>>
>

