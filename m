From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [RFC 2/2] mmc: use SD/MMC host ID for block device name ID
Date: Tue, 01 Apr 2014 14:47:36 -0600
Message-ID: <533B25E8.8040201@wwwdotorg.org>
References: <cover.1396384101.git.stefan@agner.ch> <2f6ac51155f9d34791b274b5102d15a997ff8b99.1396384101.git.stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:43756 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbaDAUrk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Apr 2014 16:47:40 -0400
In-Reply-To: <2f6ac51155f9d34791b274b5102d15a997ff8b99.1396384101.git.stefan@agner.ch>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: stefan@agner.ch, chris@printf.net, linux-mmc@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org

On 04/01/2014 02:35 PM, stefan@agner.ch wrote:
> From: Stefan Agner <stefan@agner.ch>
> 
> By using the SD/MMC host device ID as a starting point for block
> device numbering, one can reliably predict the first block device
> name (at least for the first controller).

That's not true. There's no guarantee that a device name/ID gets
released as soon as the SD card is removed; something might still have
it mounted for example.

The correct solution here is to use filesystem or partition UUIDs to
identify the device/partition, not to attempt to assign static device IDs.
