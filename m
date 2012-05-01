From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/3] mmc/sdhci-spear: No need to check 'pdev == NULL' in probe
Date: Tue, 01 May 2012 10:33:09 -0400
Message-ID: <87y5pchsyi.fsf@laptop.org>
References: <841301f38cfc2d1170378306f1640d7653652505.1332817654.git.viresh.kumar@st.com>
	<4F83FF20.9010701@st.com> <4F9FA372.3060807@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:39768 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753268Ab2EAOdR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 1 May 2012 10:33:17 -0400
In-Reply-To: <4F9FA372.3060807@st.com> (Viresh Kumar's message of "Tue, 1 May
	2012 14:18:50 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Viresh Kumar <viresh.kumar@st.com>
Cc: spear-devel <spear-devel@list.st.com>, "viresh.linux@gmail.com" <viresh.linux@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "sr@denx.de" <sr@denx.de>

Hi Viresh,

On Tue, May 01 2012, Viresh Kumar wrote:
> On 4/10/2012 3:06 PM, Viresh KUMAR wrote:
>> On 3/27/2012 8:40 AM, Viresh KUMAR wrote:
>>> > pdev is guaranteed to be valid in probe. And so check is not required to check
>>> > if it is non-NULL. Remove it.
>>> > 
>>> > Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
>> Hi Chris,
>> 
>> Can you atleast apply first two patches of this set. Will rework patch 3/3 after
>> DT support is finalized by arnd.
>
> Chris,
>
> Can you please apply these?

Sorry for the delay -- I've pushed patches 1 and 2 to mmc-next for 3.5 now.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
