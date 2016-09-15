From: Don Zickus <dzickus@redhat.com>
Subject: Re: RTS5227 errors on mount
Date: Thu, 15 Sep 2016 11:11:29 -0400
Message-ID: <20160915151129.GM98438@redhat.com>
References: <20160901214047.GV98438@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44200 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752053AbcIOPLc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 15 Sep 2016 11:11:32 -0400
Content-Disposition: inline
In-Reply-To: <20160901214047.GV98438@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org

Hi Ulf,

My emails to Micky seem to get blocked.  Is there a better person to contact
about the rts5227 chip?

Cheers,
Don

On Thu, Sep 01, 2016 at 05:40:47PM -0400, Don Zickus wrote:
> Hi Micky,
> 
> I am trying to debug a lenovo T450s laptop with a Realtek rts5227 sd reader
> on it.  I was wondering if you can help me figure things out.
> 
> I am seeing the following when I insert a regular (not micro) SDXC Transcend
> 64GB card and try and mount it:
> 
> mmc0: cannot verify signal voltage switch
> mmc0: new ultra high speed SDR104 SDXC card at address 59b4
> mmcblk0: mmc0:59b4 SDU1  59.8 GiB
> mmcblk0: p1
> EXT4-fs (mmcblk0p1): mounted filesystem with ordered data mode. Opts: (null)
> mmcblk0: unknown error -22 sending read/write command, card status 0x900
> mmc0: cannot verify signal voltage switch
> 
> I was focusing on the -22 error.  It seems to be an -EINVAL set because a
> read transaction failed with TRANS_FAIL_INT.  Everything else seems fine.
> The mount succeeds and I can r/w data.
> 
> This is with the latest 4.8 kernel (older kernels have the same error too).
> 
> Turning on debugging it seems to be a CRC error? but the driver can recover
> and move on.  So the warning seems harmless.  Nonetheless various Fedora and
> RHEL folks are bothered by it and I wanted to figure out how to fix it
> correctly.
> 
> I have attached some debug logs below with MMC_DEBUG enabled and a bunch of
> dynamic_debug turned on to help.
> 
> Thoughts?
> 
> Cheers,
> Don
> 
> 
> [  333.249114] mmc0: starting CMD18 arg 078bf7f0 flags 000000b5
> [  333.249115] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
> [  333.249116] mmc0:     CMD12 arg 00000000 flags 00000095
> [  333.249134] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_long_data: SD/MMC CMD 18, arg = 0x078bf7f0
> [  333.249747] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/MMC CMD 12, arg = 0x00000000
> [  333.249779] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] = 0x00000b00
> [  333.249782] mmc0: req done (CMD18): 0: 00000000 00000000 00000000 00000000
> [  333.249784] mmc0:     4096 bytes transferred: 0
> [  333.249785] mmc0:     (CMD12): 0: 00000b00 00000000 00000000 00000000
> [  333.249832] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: pre dma sg: 1
> [  333.249834] mmc0: starting CMD18 arg 00000800 flags 000000b5
> [  333.249836] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
> [  333.249837] mmc0:     CMD12 arg 00000000 flags 00000095
> [  333.249858] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_long_data: SD/MMC CMD 18, arg = 0x00000800
> [  333.250757] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/MMC CMD 12, arg = 0x00000000
> [  333.250787] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] = 0x00000b00
> [  333.250790] mmc0: req done (CMD18): 0: 00000000 00000000 00000000 00000000
> [  333.250791] mmc0:     4096 bytes transferred: 0
> [  333.250793] mmc0:     (CMD12): 0: 00000b00 00000000 00000000 00000000
> [  333.250837] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: pre dma sg: 1
> [  333.250839] mmc0: starting CMD18 arg 00000808 flags 000000b5
> [  333.250841] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
> [  333.250842] mmc0:     CMD12 arg 00000000 flags 00000095
> [  333.250865] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_long_data: SD/MMC CMD 18, arg = 0x00000808
> [  333.251604] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFDA0(8): 09 01 04 48 00 1f 00 00
> [  333.251631] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFDA8(8): 00 12 00 00 09 00 d3 00
> [  333.251648] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFDB0(4): 02 07 00 7e 00 00 00 00
> [  333.251676] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFD52(8): 04 41 00 04 00 00 00 02
> [  333.251703] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFD5A(8): b3 00 02 01 b3 b3 55 aa
> [  333.251730] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFD62(8): e9 59 55 15 04 00 24 04
> [  333.251740] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/MMC CMD 12, arg = 0x00000000
> [  333.251766] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] = 0x00000b00
> [  333.251770] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: CMD 18 0x00000808 error(-22)
> [  333.251773] mmc0: req done (CMD18): -22: 00000000 00000000 00000000 00000000
> [  333.251775] mmc0:     0 bytes transferred: 0
> [  333.251778] mmc0:     (CMD12): 0: 00000b00 00000000 00000000 00000000
> [  333.251789] mmc0: starting CMD13 arg 59b40000 flags 00000195
> [  333.251814] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/MMC CMD 13, arg = 0x59b40000
> [  333.251837] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] = 0x00000900
> [  333.251839] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> [  333.251848] mmcblk0: unknown error -22 sending read/write command, card status 0x900
> 
> ^^^^ here is the bad transaction
> 
> [  333.251857] mmc0: clock 0Hz busmode 2 powermode 0 cs 0 Vdd 0 width 1 timing 0
> [  333.257218] mmc0: clock 0Hz busmode 2 powermode 1 cs 0 Vdd 21 width 1 timing 0
> [  333.257433] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sdmmc_switch_voltage: signal_voltage = 0
> [  333.257617] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: Initial signal voltage of 3.3v
> [  333.269259] mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 1 timing 0
> [  333.281210] mmc0: clock 400000Hz busmode 2 powermode 2 cs 1 Vdd 21 width 1 timing 0
> [  333.284228] mmc0: starting CMD0 arg 00000000 flags 000000c0
> [  333.284243] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/MMC CMD 0, arg = 0x00000000
> [  333.284571] mmc0: req done (CMD0): 0: 00000000 00000000 00000000 00000000
> [  333.287262] mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 1 timing 0
> [  333.290235] mmc0: starting CMD8 arg 000001aa flags 000002f5
> [  333.290263] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/MMC CMD 8, arg = 0x000001aa
> [  333.290904] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] = 0x000001aa
> [  333.290908] mmc0: req done (CMD8): 0: 000001aa 00000000 00000000 00000000
> [  333.290964] mmc0: starting CMD55 arg 00000000 flags 000000f5
> [  333.290993] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/MMC CMD 55, arg = 0x00000000
> [  333.291743] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] = 0x00000120
> [  333.291745] mmc0: req done (CMD55): 0: 00000120 00000000 00000000 00000000
> [  333.291765] mmc0: starting CMD41 arg 51300000 flags 000000e1
> [  333.291781] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/MMC CMD 41, arg = 0x51300000
> [  333.292330] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] = 0x00ff8000
> [  333.292332] mmc0: req done (CMD41): 0: 00ff8000 00000000 00000000 00000000
> [  333.304231] mmc0: starting CMD55 arg 00000000 flags 000000f5
> [  333.304247] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/MMC CMD 55, arg = 0x00000000
> [  333.304805] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] = 0x00000120
> [  333.304806] mmc0: req done (CMD55): 0: 00000120 00000000 00000000 00000000
> [  333.304828] mmc0: starting CMD41 arg 51300000 flags 000000e1
> [  333.304847] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/MMC CMD 41, arg = 0x51300000
> [  333.305398] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] = 0x00ff8000
> [  333.305401] mmc0: req done (CMD41): 0: 00ff8000 00000000 00000000 00000000
> [  333.317258] mmc0: starting CMD55 arg 00000000 flags 000000f5
> [  333.317284] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/MMC CMD 55, arg = 0x00000000
> [  333.317911] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] = 0x00000120
> [  333.317925] mmc0: req done (CMD55): 0: 00000120 00000000 00000000 00000000
> [  333.317961] mmc0: starting CMD41 arg 51300000 flags 000000e1
> [  333.317997] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/MMC CMD 41, arg = 0x51300000
> [  333.318549] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] = 0x00ff8000
> [  333.318552] mmc0: req done (CMD41): 0: 00ff8000 00000000 00000000 00000000
> [  333.330205] mmc0: starting CMD55 arg 00000000 flags 000000f5
> [  333.330221] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/MMC CMD 55, arg = 0x00000000
> [  333.330769] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] = 0x00000120
> [  333.330771] mmc0: req done (CMD55): 0: 00000120 00000000 00000000 00000000
> 
> <snip>
> 
> [  333.710266] mmc0: starting CMD2 arg 00000000 flags 00000067
> [  333.710285] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/MMC CMD 2, arg = 0x00000000
> [  333.711279] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] = 0x744a6053
> [  333.711281] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[1] = 0x44553120
> [  333.711282] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[2] = 0x2013a206
> [  333.711282] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[3] = 0xe100ea01
> [  333.711285] mmc0: req done (CMD2): 0: 744a6053 44553120 2013a206 e100ea01
> [  333.711310] mmc0: starting CMD3 arg 00000000 flags 00000075
> [  333.711335] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/MMC CMD 3, arg = 0x00000000
> [  333.711884] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] = 0x59b40500
> [  333.711887] mmc0: req done (CMD3): 0: 59b40500 00000000 00000000 00000000
> [  333.711894] mmc0: starting CMD7 arg 59b40000 flags 00000015
> [  333.711908] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/MMC CMD 7, arg = 0x59b40000
> [  333.712459] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] = 0x00000700
> [  333.712462] mmc0: req done (CMD7): 0: 00000700 00000000 00000000 00000000
> [  333.712472] mmc0: starting CMD55 arg 59b40000 flags 00000095
> [  333.712499] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/MMC CMD 55, arg = 0x59b40000
> [  333.713047] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] = 0x00000920
> [  333.713049] mmc0: req done (CMD55): 0: 00000920 00000000 00000000 00000000
> [  333.713066] mmc0: starting CMD6 arg 00000002 flags 00000015
> [  333.713086] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/MMC CMD 6, arg = 0x00000002
> [  333.713640] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] = 0x00000920
> [  333.713642] mmc0: req done (CMD6): 0: 00000920 00000000 00000000 00000000
> [  333.713652] mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 4 timing 0
> [  333.713690] mmc0: starting CMD6 arg 80ff1fff flags 000000b5
> [  333.713692] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 100 ms nsac 0
> [  333.713720] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD 6, arg = 0x80ff1fff
> [  333.714061] mmc0: req done (CMD6): 0: 00000000 00000000 00000000 00000000
> [  333.714062] mmc0:     64 bytes transferred: 0
> [  333.714068] mmc0: starting CMD6 arg 80fffff3 flags 000000b5
> [  333.714070] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 100 ms nsac 0
> [  333.714092] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD 6, arg = 0x80fffff3
> [  333.714507] mmc0: req done (CMD6): 0: 00000000 00000000 00000000 00000000
> [  333.714509] mmc0:     64 bytes transferred: 0
> [  333.714519] mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 4 timing 6
> [  333.714551] mmc0: clock 208000000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 4 timing 6
> [  333.714609] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(TX): sample_point = 27
> [  333.714627] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): sample_point = 0
> [  333.714645] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD 19, arg = 0x00000000
> [  333.714773] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): sample_point = 1
> [  333.714790] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD 19, arg = 0x00000000
> [  333.714917] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): sample_point = 2
> [  333.714935] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD 19, arg = 0x00000000
> [  333.715061] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): sample_point = 3
> [  333.715078] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD 19, arg = 0x00000000
> [  333.715205] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): sample_point = 4
> [  333.715230] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD 19, arg = 0x00000000
> [  333.715370] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): sample_point = 5
> [  333.715390] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD 19, arg = 0x00000000
> [  333.715522] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): sample_point = 6
> [  333.715540] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD 19, arg = 0x00000000
> [  333.715670] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): sample_point = 7
> [  333.715687] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD 19, arg = 0x00000000
> [  333.715813] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): sample_point = 8
> [  333.715830] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD 19, arg = 0x00000000
> [  333.715958] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): sample_point = 9
> [  333.715983] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD 19, arg = 0x00000000
> [  333.716113] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): sample_point = 10
> [  333.716134] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD 19, arg = 0x00000000
> [  333.716268] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): sample_point = 11
> [  333.716287] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD 19, arg = 0x00000000
> [  333.716417] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): sample_point = 12
> [  333.716437] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD 19, arg = 0x00000000
> [  333.716568] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): sample_point = 13
> [  333.716587] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD 19, arg = 0x00000000
> [  333.716717] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): sample_point = 14
> [  333.716736] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD 19, arg = 0x00000000
> [  333.716866] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): sample_point = 15
> [  333.716885] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD 19, arg = 0x00000000
> [  333.717015] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): sample_point = 16
> [  333.717035] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD 19, arg = 0x00000000
> [  333.717165] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): sample_point = 17
> [  333.717184] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD 19, arg = 0x00000000
> [  333.717316] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): sample_point = 18
> [  333.717337] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD 19, arg = 0x00000000
> [  333.717386] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFDA0(8): 09 01 04 88 00 1f 00 00
> [  333.717413] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFDA8(8): 00 13 00 00 09 00 ff 40
> [  333.717430] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFDB0(4): 00 01 00 7f 00 00 00 00
> [  333.717457] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFD52(8): 04 41 00 04 00 00 00 02
> [  333.717483] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFD5A(8): b3 01 02 01 b3 b3 55 aa
> [  333.717510] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFD62(8): e9 59 55 15 04 00 24 04
> [  333.717512] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd fail (err = -22)
> [  333.717524] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): sample_point = 19
> [  333.717546] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD 19, arg = 0x00000000
> [  333.717594] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFDA0(8): 09 01 04 88 00 1f 00 00
> [  333.717621] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFDA8(8): 00 37 00 00 1b 01 ff 40
> [  333.717638] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFDB0(4): 00 01 00 7f 00 00 00 00
> [  333.717665] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFD52(8): 04 41 00 04 00 00 00 02
> [  333.717691] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFD5A(8): b3 01 02 01 b3 b3 55 aa
> [  333.717717] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFD62(8): e9 59 55 15 04 00 24 04
> [  333.717720] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd fail (err = -22)
> [  333.717731] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): sample_point = 20
> [  333.717751] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD 19, arg = 0x00000000
> [  333.717907] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFDA0(8): 09 01 04 49 00 1f 00 00
> [  333.717934] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFDA8(8): 00 13 00 00 09 00 bf 40
> [  333.717951] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFDB0(4): 00 00 00 7f 00 00 00 00
> [  333.717977] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFD52(8): 04 41 00 04 00 00 00 02
> [  333.718004] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFD5A(8): b3 01 02 01 b3 b3 55 aa
> [  333.718030] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFD62(8): e9 59 55 15 04 00 24 04
> [  333.718033] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd fail (err = -22)
> [  333.718044] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): sample_point = 21
> [  333.718063] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD 19, arg = 0x00000000
> [  333.718227] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFDA0(8): 09 01 04 49 00 1f 00 00
> [  333.718254] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFDA8(8): 00 13 00 00 09 00 bf 40
> [  333.718281] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFDB0(4): 00 00 00 7f 00 00 00 00
> [  333.718306] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFD52(8): 04 41 00 04 00 00 00 02
> [  333.718330] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFD5A(8): b3 01 02 01 b3 b3 55 aa
> [  333.718355] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFD62(8): e9 59 55 15 04 00 24 04
> [  333.718356] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd fail (err = -22)
> [  333.718367] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): sample_point = 22
> [  333.718384] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD 19, arg = 0x00000000
> [  333.718537] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFDA0(8): 09 01 04 49 00 1f 00 00
> [  333.718561] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFDA8(8): 00 13 00 00 09 00 bf 40
> [  333.718572] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFDB0(4): 00 00 00 7f 00 00 00 00
> [  333.718597] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFD52(8): 04 41 00 04 00 00 00 02
> [  333.718622] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFD5A(8): b3 01 02 01 b3 b3 55 aa
> [  333.718646] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: 0xFD62(8): e9 59 55 15 04 00 24 04
> [  333.718648] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd fail (err = -22)
> [  333.718659] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): sample_point = 23
> [  333.718676] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD 19, arg = 0x00000000
> [  333.718803] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): sample_point = 24
> [  333.718820] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD 19, arg = 0x00000000
> [  333.718946] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): sample_point = 25
> [  333.718963] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD 19, arg = 0x00000000
> [  333.719090] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): sample_point = 26
> [  333.719106] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD 19, arg = 0x00000000
> [  333.719234] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): sample_point = 27
> [  333.719251] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD 19, arg = 0x00000000
> [  333.719378] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): sample_point = 28
> [  333.719395] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD 19, arg = 0x00000000
> [  333.719521] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): sample_point = 29
> [  333.719539] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD 19, arg = 0x00000000
> [  333.719668] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): sample_point = 30
> [  333.719685] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD 19, arg = 0x00000000
> [  333.719811] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): sample_point = 31
> [  333.719828] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD 19, arg = 0x00000000
> 
> ^^^^^^^^^^ some other random failures.  Related to 'verify voltage' warnings??
