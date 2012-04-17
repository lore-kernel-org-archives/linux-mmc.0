From: Viresh Kumar <viresh.kumar@st.com>
Subject: Re: [PATCH] mmc: sdhci-spear: Add clk_{un}prepare() support
Date: Tue, 17 Apr 2012 16:35:46 +0530
Message-ID: <4F8D4E8A.7090602@st.com>
References: <f0a8be5938e41e3c9dc6ab07fffe03900885ca7f.1334655823.git.viresh.kumar@st.com> <006f01cd1c89$a52f7320$ef8e5960$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:42581 "EHLO
	eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752221Ab2DQLHf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Apr 2012 07:07:35 -0400
In-Reply-To: <006f01cd1c89$a52f7320$ef8e5960$@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, spear-devel <spear-devel@list.st.com>, "viresh.linux@gmail.com" <viresh.linux@gmail.com>

On 4/17/2012 4:32 PM, Subhash Jadavani wrote:
> It's better to use clk_prepare_enable() helper function if you are doing
> enable immediately after prepare.

Sure. Will fix it.

-- 
viresh
