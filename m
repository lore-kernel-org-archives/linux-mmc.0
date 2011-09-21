From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc/sdhci-spear: Don't set power gpio to 1 on probe
Date: Wed, 21 Sep 2011 13:55:45 -0400
Message-ID: <m2lith4w66.fsf@bob.laptop.org>
References: <afc56880fea90e49b8e64bc379be4572381791f5.1315826468.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41805 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753211Ab1IURz5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 21 Sep 2011 13:55:57 -0400
In-Reply-To: <afc56880fea90e49b8e64bc379be4572381791f5.1315826468.git.viresh.kumar@st.com>
	(Viresh Kumar's message of "Mon, 12 Sep 2011 16:52:49 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Viresh Kumar <viresh.kumar@st.com>
Cc: akpm@linux-foundation.org, linux-mmc@vger.kernel.org, armando.visconti@st.com, shiraz.hashim@st.com, vipin.kumar@st.com, rajeev-dlh.kumar@st.com, deepak.sikri@st.com, vipulkumar.samar@st.com, amit.virdi@st.com, pratyush.anand@st.com, bhupesh.sharma@st.com, viresh.linux@gmail.com, bhavna.yadav@st.com

Hi Viresh,

On Mon, Sep 12 2011, Viresh Kumar wrote:
> Currently if card_power_gpio is passed from platform data, it is acquired and
> its value is either set or reset. After that its value is written 1, which is
> not required.
>
> So, this patch removes this extra line while sets its value.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Pushed to mmc-next for 3.2, thanks.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
