From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V2] mmc/sdhci-spear: Implement suspend/resume
Date: Tue, 15 Nov 2011 10:33:06 -0500
Message-ID: <8762ilieod.fsf@laptop.org>
References: <f255cb1f0ea01794526004ef9e0dd516014a5744.1321354417.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:42992 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756236Ab1KOPdE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 15 Nov 2011 10:33:04 -0500
In-Reply-To: <f255cb1f0ea01794526004ef9e0dd516014a5744.1321354417.git.viresh.kumar@st.com>
	(Viresh Kumar's message of "Tue, 15 Nov 2011 16:24:40 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Viresh Kumar <viresh.kumar@st.com>
Cc: linux-mmc@vger.kernel.org, armando.visconti@st.com, shiraz.hashim@st.com, vipin.kumar@st.com, rajeev-dlh.kumar@st.com, deepak.sikri@st.com, vipulkumar.samar@st.com, amit.virdi@st.com, pratyush.anand@st.com, bhupesh.sharma@st.com, viresh.linux@gmail.com, bhavna.yadav@st.com, vincenzo.frascino@st.com, mirko.gardi@st.com

Hi Viresh,

On Tue, Nov 15 2011, Viresh Kumar wrote:
> Suspend/Resume is missing from sdhci-spear driver. This patch adds support for
> suspend/resume for this driver.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Pushed to mmc-next for 3.3, thanks.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
