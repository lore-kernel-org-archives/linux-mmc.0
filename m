From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 2/2] mmc: sdhci-bcm2835: Use sdhci_pltfm_unregister instead
 of open coded
Date: Wed, 18 Sep 2013 14:51:25 -0600
Message-ID: <523A124D.9060507@wwwdotorg.org>
References: <1379404772.12080.1.camel@phoenix> <1379404847.12080.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:36873 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873Ab3IRUv2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Sep 2013 16:51:28 -0400
In-Reply-To: <1379404847.12080.3.camel@phoenix>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Chris Ball <cjb@laptop.org>, Christian Daudt <csd@broadcom.com>, linux-mmc@vger.kernel.org

On 09/17/2013 02:00 AM, Axel Lin wrote:
> This avoid duplicated implementation.

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
