From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] mmc: sdhci-spear: Initialize sdhci clk to 50 MHz
Date: Mon, 26 Nov 2012 20:34:49 +0530
Message-ID: <CAKohponQ-9gYQznnaxyhvgd0AMVHHt_s6wByOoTQpdhRmqBwPQ@mail.gmail.com>
References: <fd576f198e6f3dc4031bb905247ed9c0a0b66a20.1352387305.git.viresh.kumar@linaro.org>
	<CAKohpo=m-MZDL8B7vkrF4aQP74QCgw3uEsTnsr1k2X4p9FdHcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:37078 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754878Ab2KZPEu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Nov 2012 10:04:50 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so6431079iea.19
        for <linux-mmc@vger.kernel.org>; Mon, 26 Nov 2012 07:04:50 -0800 (PST)
In-Reply-To: <CAKohpo=m-MZDL8B7vkrF4aQP74QCgw3uEsTnsr1k2X4p9FdHcQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, spear-devel@list.st.com, Vipul Kumar Samar <vipulkumar.samar@st.com>, Viresh Kumar <viresh.kumar@linaro.org>

On 20 November 2012 12:11, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 8 November 2012 20:39, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> From: Vipul Kumar Samar <vipulkumar.samar@st.com>
>>
>> SPEAr sdhci driver expects the clock to be set to 50 MHz for proper functioning.
>> This patch sets clk to 50 MHz in probe.
>>
>> Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> Ping!!

Hi Chris,

Are you taking these for v3.8?
