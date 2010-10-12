From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] mmc_rescan: reduce verbosity
Date: Mon, 11 Oct 2010 21:50:46 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010112007250.2764@xanadu.home>
References: <1286833731-30567-1-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_O8hiRTSqdQLo8Fs4hYL2Uw)"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:18299 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756610Ab0JLBur (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Oct 2010 21:50:47 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LA500ECJMGMM430@VL-MO-MR003.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Mon, 11 Oct 2010 21:50:46 -0400 (EDT)
In-reply-to: <1286833731-30567-1-git-send-email-eric@eukrea.com>
Content-id: <alpine.LFD.2.00.1010112150100.2764@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-15?Q?Eric_B=E9nard?= <eric@eukrea.com>
Cc: linux-mmc@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_O8hiRTSqdQLo8Fs4hYL2Uw)
Content-id: <alpine.LFD.2.00.1010112150101.2764@xanadu.home>
Content-type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-transfer-encoding: 8BIT

On Mon, 11 Oct 2010, Eric Bénard wrote:

> since commit 820f2bcfdc32cd90061224c930cf670f961e12d1 mmc_rescan
> includes a pr_info which prints 4 lines each second for hosts configured
> with MMC_CAP_NEEDS_POLL. Tested on i.MX51's sdhci-esdhc.
> This patch increase log level to debug (but maybe the right solution
> would be to remove this log).

Indeed.  Flooding the log with debug messages is not much better.


Nicolas

--Boundary_(ID_O8hiRTSqdQLo8Fs4hYL2Uw)--
