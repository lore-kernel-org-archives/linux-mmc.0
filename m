From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: Adding aliases to mmc
Date: Fri, 20 Sep 2013 10:05:05 -0600
Message-ID: <523C7231.7040701@wwwdotorg.org>
References: <CAOMZO5CJ36JHJMaiG3QVdtpBoWd_ZyHQuRTrKHz4bLP39gpJtQ@mail.gmail.com> <5239C40C.9030503@wwwdotorg.org> <5239DC65.3080803@gmail.com> <5239DF55.8010308@wwwdotorg.org> <523A8A08.2060508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:45219 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942Ab3ITQFJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Sep 2013 12:05:09 -0400
In-Reply-To: <523A8A08.2060508@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dirk Behme <dirk.behme@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>, linux-mmc@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>

On 09/18/2013 11:22 PM, Dirk Behme wrote:
...
> If you have an embedded system were you just care a little about boot
> time you don't want to do anything like U-Boot's "part uuid" every time
> you boot. Or even worse, you just have a minimalistic boot loader (e.g.
> U-Boot's SPL) which doesn't know anything about UUIDs and file systems.
> 
> As mentioned above, no I don't think UUIDs work for production embedded
> systems.

As I said above, whatever generates the filesystem image can easily
embed the appropriate UUID in the system's boot scripts or bootloader
environment. There's no need to run the "part" command at run-time if
there's a more appropriate flow for your situation.
