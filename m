From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] sdhci-spear: ST SPEAr based SDHCI controller glue
Date: Thu, 20 May 2010 07:12:15 -0400
Message-ID: <20100520071215.a536b26d.akpm@linux-foundation.org>
References: <1273052118-15513-1-git-send-email-viresh.kumar@st.com>
	<20100519141013.ccb8ca9d.akpm@linux-foundation.org>
	<4BF4C9A8.1070206@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45565 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751475Ab0ETONw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 May 2010 10:13:52 -0400
In-Reply-To: <4BF4C9A8.1070206@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Viresh KUMAR <viresh.kumar@st.com>
Cc: pierre@ossman.eu, linux-mmc@vger.kernel.org, shiraz.hashim@st.com

On Thu, 20 May 2010 11:03:28 +0530 Viresh KUMAR <viresh.kumar@st.com> wrote:

> On 5/20/2010 2:40 AM, Andrew Morton wrote:
> > On Wed,  5 May 2010 15:05:18 +0530
> > Viresh KUMAR <viresh.kumar@st.com> wrote:
> > 
> >> This patch adds glue layer for support of sdhci driver on ST SPEAr platform.
> >>
> > 
> > Looks OK to my untrained eye.  A few very minor things:
> 
> Andrew,
> 
> Should i send V2 of complete patch again or patch on original patch,
> with review comments incorporated (As patch is already added in -mm tree)?
> 

Either is OK for me.  I will turn a replacement patch into an
incremental patch so I can see what changed.  Then I'll turn it all
back into a single patch before sending it upstream.


