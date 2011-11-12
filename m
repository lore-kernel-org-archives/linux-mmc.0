From: Chris Ball <cjb@laptop.org>
Subject: Re: [Query] mmc/sdhci: Suspend hangs if card is inserted at suspend.
Date: Fri, 11 Nov 2011 22:24:29 -0500
Message-ID: <877h36hvki.fsf@laptop.org>
References: <4EBCC49E.5060008@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:34826 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751253Ab1KLDY3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 11 Nov 2011 22:24:29 -0500
In-Reply-To: <4EBCC49E.5060008@st.com> (Viresh Kumar's message of "Fri, 11 Nov
	2011 12:15:50 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Viresh Kumar <viresh.kumar@st.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shiraz HASHIM <shiraz.hashim@st.com>, Armando VISCONTI <armando.visconti@st.com>

Hi Viresh,

On Fri, Nov 11 2011, Viresh Kumar wrote:
> Controller specific suspend/resume are still not called, so i think it might
> be related to core code. I am using 2.6.37 kernel version.
>
> Any help on this?

Please try to reproduce on 3.1 and let us know if it's present there.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
