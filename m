From: Chris Ball <cjb@laptop.org>
Subject: Re: mmc_test mmc0:0001: Can't create file. Perhaps debugfs is
	disabled
Date: Wed, 5 Jan 2011 03:48:32 +0000
Message-ID: <20110105034832.GB31464@void.printf.net>
References: <4D11E833.7000506@st.com> <20110104180113.GA17407@void.printf.net> <4D23E763.7060402@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:49195 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750995Ab1AEDse (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 4 Jan 2011 22:48:34 -0500
Content-Disposition: inline
In-Reply-To: <4D23E763.7060402@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: viresh kumar <viresh.kumar@st.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shiraz HASHIM <shiraz.hashim@st.com>

Hi Viresh,

On Wed, Jan 05, 2011 at 09:07:07AM +0530, viresh kumar wrote:
> Actually i am bit new to LKML and i don't know if i should send the patch again
> with signed-off or simply send a signed-off: in a similar way as we send
> Acked-by:. Please tell me if i need to resend patch.

No need to resend, you did everything right.  I've pushed the patch with
your S-o-b to mmc-next for .38 now, thanks!

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
