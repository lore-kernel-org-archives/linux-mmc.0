From: Holger Schurig <holgerschurig@gmail.com>
Subject: Re: [LINUX PATCH 5/5] mmc: host: Update the quirks for this controller.
Date: Tue, 19 Jan 2016 17:05:04 +0100
Message-ID: <87fuxt4ksv.fsf@gmail.com>
References: <1453213055-35563-1-git-send-email-lakshmis@xilinx.com>
	<1453213055-35563-5-git-send-email-lakshmis@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453213055-35563-5-git-send-email-lakshmis@xilinx.com> (P. L.
	Sai Krishna's message of "Tue, 19 Jan 2016 19:47:35 +0530")
Sender: linux-kernel-owner@vger.kernel.org
To: P L Sai Krishna <lakshmi.sai.krishna.potthuri@xilinx.com>
Cc: Michal Simek <michal.simek@xilinx.com>, Soren Brinkmann <soren.brinkmann@xilinx.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hao <haokexin@gmail.com>, Emil Lenchak <emill@xilinx.com>, Tobias Klauser <tklauser@distanz.ch>, Sudeep Holla <Sudeep.Holla@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, Jisheng Zhang <jszhang@marvell.com>, "Ivan T. Ivanov" <ivan.ivanov@linaro.org>, Scott Branden <sbranden@broadcom.com>, Vincent Yang <vincent.yang.fujitsu@gmail.com>, Haibo Chen <haibo.chen@freescale.com>, Marek Vasut <marex@denx.de>, "ludovic.desroches@atmel.com" <ludovic.desroches@atmel.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Suman Tripathi <stripathi@apm.com>, Shawn Lin <shawn.lin@rock-chips.com>, devicetree@vger
List-Id: linux-mmc@vger.kernel.org

Hi,

Don't write "of this controller" into subject, write "of sdhci-arasan"
or something like it.

Otherwise people will have to look into your patch description ...

> This patch adds SDHCI_QUIRK2_STOP_WITH_TC quirk to remove
> the following error message.
> "mmc0: Got data interrupt 0x00000002 even though no data
> operation was in progress"

But wait, it's not there, too. So people have to look into the patch
itself. :-(



Holger
