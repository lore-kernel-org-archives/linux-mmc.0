From: Viresh KUMAR <viresh.kumar@st.com>
Subject: Query: spear sdhci: Getting DATA CRC Error Interrupt with SD and
 MicroSD cards.
Date: Mon, 05 Jul 2010 14:43:02 +0530
Message-ID: <4C31A21E.6020503@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:45576 "EHLO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752156Ab0GEJkU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Jul 2010 05:40:20 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org

Hello,

We have ARASAN SDHCI controller in SPEAr1300, and using sdhci.c
and sdhci-spear.c drivers.

When we insert MMC card then it works fine, we are able to run
mmc_test on it. But when we insert SD or MicroSD card then we get
-84 error and it was due to DATA CRC Error Interrupt.
I have also tried FORCE_1_BIT quirk and running SDHCI at around 800 MHz.

Can somebody please help me on this?? Anything that i can try to test??


viresh.
