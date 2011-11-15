From: Viresh Kumar <viresh.kumar@st.com>
Subject: Re: [PATCH] mmc/sdhci-spear: Implement suspend/resume
Date: Tue, 15 Nov 2011 16:16:41 +0530
Message-ID: <4EC24311.1060100@st.com>
References: <d91523b382aa22a6d274be8c88227e0bfdefc944.1321346114.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog114.obsmtp.com ([207.126.144.137]:48652 "EHLO
	eu1sys200aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754935Ab1KOKq4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Nov 2011 05:46:56 -0500
In-Reply-To: <d91523b382aa22a6d274be8c88227e0bfdefc944.1321346114.git.viresh.kumar@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "cjb@laptop.org" <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Armando VISCONTI <armando.visconti@st.com>, Shiraz HASHIM <shiraz.hashim@st.com>, Vipin KUMAR <vipin.kumar@st.com>, Rajeev KUMAR <rajeev-dlh.kumar@st.com>, Deepak SIKRI <deepak.sikri@st.com>, Vipul Kumar SAMAR <vipulkumar.samar@st.com>, Amit VIRDI <Amit.VIRDI@st.com>, Pratyush ANAND <pratyush.anand@st.com>, Bhupesh SHARMA <bhupesh.sharma@st.com>, "viresh.linux@gmail.com" <viresh.linux@gmail.com>, Bhavna YADAV <bhavna.yadav@st.com>, Vincenzo FRASCINO <Vincenzo.FRASCINO@st.com>, Mirko GARDI <mirko.gardi@st.com>

On 11/15/2011 2:06 PM, Viresh KUMAR wrote:
> +#ifdef CONFIG_PM
> +static int sdhci_suspend(struct device *dev)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +	pm_message_t state = {.event = 0};
> +
> +	return sdhci_suspend_host(host, state);

Chris,

Please discard this patch, i need to take care of clk too in suspend/resume.
Will fix it and resend it.

-- 
viresh
