From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Subject: Re: mmc-utils: Initial contribute of lsmmc
Date: Thu, 21 Jun 2012 10:47:58 +0200
Message-ID: <4FE2DFBE.2010105@st.com>
References: <E2E6AC6BFAD06343BA2D97432459C1B60AD59DF92E@EXDCVYMBSTM005.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:54090 "EHLO
	eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758879Ab2FUIsH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jun 2012 04:48:07 -0400
In-Reply-To: <E2E6AC6BFAD06343BA2D97432459C1B60AD59DF92E@EXDCVYMBSTM005.EQ1STM.local>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan RUDHOLM <johan.rudholm@stericsson.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Sebastian Rasmussen <sebras@gmail.com>, Per FORLIN <per.forlin@stericsson.com>, Ulf HANSSON <ulf.hansson@stericsson.com>

Hello Johan.

On 6/21/2012 9:44 AM, Johan RUDHOLM wrote:
> Dear all,
> 
> this is a release to the community of the source code of the utility
> "lsmmc", created by Sebastian Rasmussen formerly at ST-Ericsson.
> 
> lsmmc contains an extensive parser of the CID, CSD, SCR and EXT_CSD
> registers, as well as an archive of these registers for over 120
> eMMC and SD-cards. The utility works as-is and uses sysfs to read the
> register values.
> 
> It could be a candidate for incorporation into the mmc-utils, but it
> naturally requires some adaptation. Please consider this code to be at
> your disposal.

FYI, some work has been already done (and reviewed by Sebastian); take a
look at

http://git.kernel.org/?p=linux/kernel/git/cjb/mmc-utils.git;a=commit;h=a5bf4a2030a9dcfbcebf1b647e65c1e936a56e14

Peppe

> Chris: I decided that a .tar.gz was more tasteful in the end, the patch
> whould have contained lines > 1000 chars and been 8000 lines long ;)
> 
> Kind regards, Johan
> 


