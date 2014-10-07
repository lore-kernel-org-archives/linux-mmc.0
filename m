From: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
Subject: Re: [PATCH 0/2] mxcmmc driver fixes
Date: Tue, 07 Oct 2014 14:50:51 +0200
Message-ID: <5433E1AB.7070204@sirius-es.it>
References: <1412089178-21946-1-git-send-email-matteo.facchinetti@sirius-es.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1412089178-21946-1-git-send-email-matteo.facchinetti@sirius-es.it>
Sender: linux-kernel-owner@vger.kernel.org
To: chris@printf.net, ulf.hansson@linaro.org
Cc: shc_work@mail.ru, s.hauer@pengutronix.de, peter.griffin@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, agust@denx.de, gsi@denx.de, sbabic@denx.de
List-Id: linux-mmc@vger.kernel.org

Does anyone have any comments?


On 30/09/2014 16:59, Matteo Facchinetti wrote:
> From: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
>
> Hi,
>
> this patchset contains fixes for the mxcmmc driver.
>
> *Patch 1:
> fix a rare race condition that breaks a data trasfer when mxcmmc
> driver use dma.
> To reproduce this error, use mmc as rootfs and start at boot time
> a realtime Xenomai application.
> The realtime it's not directly related but entropy produced by
> ipipe scheduler highlights the problem.
> When this event occurs, the mxcmmc watchdog expires,
> this cause a read error and application doesn't run.
>
> *Patch 2:
> fix the default value for available voltages into mxcmci_probe
>
> Applied to mainline Linux-3.17.0-rc6-next on arch mpc512x.
> Tested on mpc5125twr evaluation board
>
> Applied to custom Linux-3.9.4 on arch mpc512x
> Tested on a mpc5125 custom board.
>
> Regards,
> Matteo Facchinetti
> Sirius Electronic Systems
>
>
> Matteo Facchinetti (2):
>    mmc: mxcmmc: fix race condition when dma finish a data transfer
>    mmc: mxcmmc: fix the default value for available voltages into
>      mxcmci_probe
>
>   drivers/mmc/host/mxcmmc.c | 27 ++++++++++-----------------
>   1 file changed, 10 insertions(+), 17 deletions(-)
>
