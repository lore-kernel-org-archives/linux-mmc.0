From: =?ISO-8859-1?Q?Kevyn=2DAlexandre_Par=E9?=
	<kevyn.alexandre.pare@gmail.com>
Subject: Unable to randomly boot rootfs (EXT3 or EXT4) from SD: MMC error -110 (TIMEDOUT)
Date: Sun, 21 Jul 2013 13:07:43 -0400
Message-ID: <CAL1yNcJZBSSNu4aDmL6n9uu3LkNPCOM-LbUXD2990jkPJYpLoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ext4-owner@vger.kernel.org>
Sender: linux-ext4-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: linux-ext4@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

I'm trying to figure out why when randomly booting our system after it =
have been hard shutdown for some time (couple of minutes to couple of =
days) doesn't boot with MMC error?=20

WORKAROUND:
Rebooting the system most of the time remove the issue.

I try couple of version of Kernel from stable 3.2.47 & 3.4.53 without =
success.
I try to change FS from EXT3 to EXT4 without success.
I try multiple SD..

Any proposition of test that you think that is worth trying, I'm willing =
to try.

Your opinions will really be appreciated,

See below for some output of my environment,
http://pastebin.com/qchsr1FQ

Thx,

-Kevyn-Alexandre Par=E9
ps: My intention are to enable CONFIG_MMC_DEBUG? Try kernel 3.10.1?
