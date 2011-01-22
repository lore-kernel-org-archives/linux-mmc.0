From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 1/3] mmc: add per device quirk placeholder
Date: Sun, 23 Jan 2011 00:55:22 +0200
Message-ID: <AANLkTik=R=VtaHrUCg_1oAXzjKy7XCBpCsEWTrq3=sNt@mail.gmail.com>
References: <cover.1294588491.git.tardyp@gmail.com> <6191610532f25d7cda435781ce9b83bfdb677b5a.1294588491.git.tardyp@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37686 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254Ab1AVWzn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 22 Jan 2011 17:55:43 -0500
In-Reply-To: <6191610532f25d7cda435781ce9b83bfdb677b5a.1294588491.git.tardyp@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pierre Tardy <tardyp@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Pierre Tardy <pierre.tardy@intel.com>

On Sun, Jan 9, 2011 at 6:26 PM, Pierre Tardy <tardyp@gmail.com> wrote:
> From: Pierre Tardy <pierre.tardy@intel.com>
>
> Some cards have quirks valid for every platforms
> using current platform quirk hooks leads to a lot
> of code and debug duplication.
>
> So we inspire a bit from what exists in PCI subsystem
> and do our own per vendorid/deviceid quirk
> We still drop the complexity of the pci quirk system
> (with special section tables, and so on)
> That can be added later if needed.

I like this.

It's exactly what we need for the wl12xx, so thanks for pushing this.

I'm not sure about the necessity of the function hooks though - it
just looks like complexity that we don't really need, and I would
rather have this framework directly set the required quirks like USB
is doing. I do see the benefit it provides you with the gating
framework and the SDIO set/unset issue, and I don't have a cleaner
alternative approach, so I guess we can live with it.

Acked-by: Ohad Ben-Cohen <ohad@wizery.com>
