From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v8 6/6] mmc: sh_mobile_sdhi: Add tuning support
Date: Thu, 26 Jan 2017 10:58:45 +0100
Message-ID: <20170126095845.GB21851@verge.net.au>
References: <1478182564-18762-1-git-send-email-horms+renesas@verge.net.au>
 <1478182564-18762-7-git-send-email-horms+renesas@verge.net.au>
 <20170110210848.GA25542@bigcity.dyn.berto.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:46145 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753344AbdAZJ6y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Jan 2017 04:58:54 -0500
Content-Disposition: inline
In-Reply-To: <20170110210848.GA25542@bigcity.dyn.berto.se>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Ai Kyuse <ai.kyuse.uw@renesas.com>

On Tue, Jan 10, 2017 at 10:08:48PM +0100, Niklas Söderlund wrote:
> Hi Simon,
> 
> I started to se errors when I was testing DMAC+IPMMU patches on top of 
> v4.10-rc1 on Koelsch.

There has been some discussion in this thread already. I would like to
provide some more information in case it is useful.

The 3.5.0 BSP appears to contain several that may be relevant to this
discussion:

383c4437846d mmc: sh_mobile_sdhi: Add detecting a change point of data to SCC tuning
1823812e0937 mmc: tmio: Add detecting a change point of data to SCC tunin
03935e9182d9 mmc: tmio: Fix tuning flow
c711db03349c mmc: sh_mobile_sdhi: Fix sampling clock position selecting
2838a2ff8ca7 mmc: tmio: fix soft lockup on CMD12 for R-Car SDHI


Of these, so far I have looked into "mmc: tmio: Fix tuning flow".
It seems to do several things:

- Ensure tuning initialisation is called for each tuning procedure:
  this seems a correct fix for a bug added by me
- Do not terminate tuning on error:
  this is not my reading of the documentation but may well be correct
- Reset more:
  I am least sure about this as it does not seem to have any explanation
  in the changelog

