From: "Steven J. Hill" <Steven.Hill@cavium.com>
Subject: Re: MMC block addressing mode.
Date: Thu, 20 Apr 2017 16:24:28 -0500
Message-ID: <ebc19d7d-c6a2-0886-a17a-e1b4d82f957e@cavium.com>
References: <f1cbb93e-68f0-df11-5e89-7b52e00a0b79@cavium.com>
 <CAPDyKFqfEQ6POgoSFL=t0nP62CB13DNL0m8m-Vzqaw0GMAV3qg@mail.gmail.com>
 <ef902f01-96fb-a314-e57c-bde8e1545b66@cavium.com>
 <c503aae1-4162-4398-1645-9e2acab5d002@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c503aae1-4162-4398-1645-9e2acab5d002@caviumnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>, Ulf Hansson <ulf.hansson@linaro.org>, Jan Glauber <jan.glauber@caviumnetworks.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 04/20/2017 12:12 PM, David Daney wrote:
> 
> Steven and Jan:  Can we get around this requirement by:
> 
> - Always set MIO_EMM_DMA[MULTI] = 1;  This way by SECTOR mode may be unimportant.
> 
> - Always set MIO_EMM_DMA[SECTOR] = SUITABLE_CONSTANT.
> 
No, this does not work. The 1.88GB card plugged into my 78xx
board gives the output below. We cannot just blindly set the
MULTI bit for all cards. These results are identical for all
four combinations of SECTOR and MULTI values hardcoded.


mmc0: host does not support reading read-only switch, assuming write-enable
mmc0: new high speed SD card at address d15e
mmcblk0: mmc0:d15e SD02G 1.88 GiB
mmcblk0: timed out sending r/w cmd command, card status 0x400900
mmcblk0: command error, retrying timeout
mmcblk0: timed out sending r/w cmd command, card status 0x400900
mmcblk0: command error, retrying timeout
mmcblk0: timed out sending r/w cmd command, card status 0x400900
mmcblk0: command error, retrying timeout
mmcblk0: timed out sending r/w cmd command, card status 0x400900
mmcblk0: command error, retrying timeout
mmcblk0: timed out sending r/w cmd command, card status 0x400900
mmcblk0: command error, retrying timeout
mmcblk0: timed out sending r/w cmd command, card status 0x400900
mmcblk0: command error, retrying timeout
mmcblk0: timed out sending r/w cmd command, card status 0x400900
mmcblk0: command error, retrying timeout
blk_update_request: I/O error, dev mmcblk0, sector 0
Buffer I/O error on dev mmcblk0, logical block 0, async page read
mmcblk0: timed out sending r/w cmd command, card status 0x400900
mmcblk0: command error, retrying timeout
mmcblk0: timed out sending r/w cmd command, card status 0x400900
mmcblk0: command error, retrying timeout
mmcblk0: timed out sending r/w cmd command, card status 0x40090
