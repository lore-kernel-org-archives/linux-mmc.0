From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/3 V2] mmc:core: parse voltage from device-tree
Date: Fri, 9 Aug 2013 09:48:09 -0500
Message-ID: <733059D3-105A-437B-B330-763D2C1859B2@kernel.crashing.org>
References: <1375251927-3330-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:39934 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030310Ab3HIOsa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Aug 2013 10:48:30 -0400
In-Reply-To: <1375251927-3330-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haijun Zhang <Haijun.Zhang@freescale.com>
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, scottwood@freescale.com, cjb@laptop.org, AFLEMING@freescale.com, cbouatmailru@gmail.com


On Jul 31, 2013, at 1:25 AM, Haijun Zhang wrote:

> Add function to support get voltage from device-tree.
> If there are voltage-range specified in device-tree node, this function
> will parse it and return the avail voltage mask.
> 
> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
> ---
> changes for v2:
> 	- Update the parameters of function
> 
> drivers/mmc/core/core.c  | 46 ++++++++++++++++++++++++++++++++++++++++++++++
> include/linux/mmc/core.h |  1 +
> 2 files changed, 47 insertions(+)

There should be a device tree binding spec update to go with this patch series.

- k