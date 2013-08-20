From: Chris Ball <cjb@laptop.org>
Subject: Re: SDHCI - Add QUIRK2_BROKEN_WRITE_PROTEXT - Support Xilinx Zynq (Linux 3.9.0)
Date: Tue, 20 Aug 2013 19:13:11 +0100
Message-ID: <86li3wdydk.fsf@void.printf.net>
References: <BEDA323D25EF6045A68DAB9FD91A0BF14A5E84DB@AMSPRD0411MB426.eurprd04.prod.outlook.com>
	<521366EA.7080705@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <521366EA.7080705@monstr.eu> (Michal Simek's message of "Tue, 20
	Aug 2013 14:54:02 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: monstr@monstr.eu
Cc: James Walmsley <james@fullfat-fs.co.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tue, Aug 20 2013, Michal Simek wrote:
> Hi James,
>
> isn't it better to implement host->ops->get_ro() function for it?
> It seems me better choice than introducing new quirk option.

Yes, I agree.  Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
