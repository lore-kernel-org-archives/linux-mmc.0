From: Viresh Kumar <viresh.kumar@st.com>
Subject: Re: [PATCH 1/3] mmc/sdhci-spear: No need to check 'pdev == NULL'
 in probe
Date: Tue, 10 Apr 2012 15:06:32 +0530
Message-ID: <4F83FF20.9010701@st.com>
References: <841301f38cfc2d1170378306f1640d7653652505.1332817654.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:39769 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752915Ab2DJJiQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Apr 2012 05:38:16 -0400
In-Reply-To: <841301f38cfc2d1170378306f1640d7653652505.1332817654.git.viresh.kumar@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "cjb@laptop.org" <cjb@laptop.org>
Cc: spear-devel <spear-devel@list.st.com>, "viresh.linux@gmail.com" <viresh.linux@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "sr@denx.de" <sr@denx.de>

On 3/27/2012 8:40 AM, Viresh KUMAR wrote:
> pdev is guaranteed to be valid in probe. And so check is not required to check
> if it is non-NULL. Remove it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Hi Chris,

Can you atleast apply first two patches of this set. Will rework patch 3/3 after
DT support is finalized by arnd.

-- 
viresh
