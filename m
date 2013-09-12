From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/1] mmc: sdhci-spear: Fix NULL pointer dereference
Date: Thu, 12 Sep 2013 13:52:36 +0530
Message-ID: <CAK9yfHw16Nk2bBpCrZN0b-manzL7MvqFiuerAzdsOCpzrju96A@mail.gmail.com>
References: <1378968200-16577-1-git-send-email-sachin.kamat@linaro.org>
	<CAKohponUT5hh=saFcx7riFJB-DbPwhkYz2_7Gc2i--GWC6bYCg@mail.gmail.com>
	<CAK9yfHzpLj6ZAcqikFWkOSWCSpU_NvchETgG0_65sU1Kb_F=kA@mail.gmail.com>
	<CAKohponoo6Kjc6P=e2K0ys6iZ7upB24UGhBNeSbg22M8qqTkWw@mail.gmail.com>
	<CAK9yfHzORfv84mDrH_KCx79Oi5w9jdtLk3MuOu8Dex1+M3N6EQ@mail.gmail.com>
	<CAKohpomgTk+JoHJpzNEqQRUXB5AHT+ijChc=0t3VKa+KtMcDRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:36869 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939Ab3ILIWg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Sep 2013 04:22:36 -0400
Received: by mail-ob0-f179.google.com with SMTP id wn1so212083obc.10
        for <linux-mmc@vger.kernel.org>; Thu, 12 Sep 2013 01:22:36 -0700 (PDT)
In-Reply-To: <CAKohpomgTk+JoHJpzNEqQRUXB5AHT+ijChc=0t3VKa+KtMcDRw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, spear-devel <spear-devel@list.st.com>

On 12 September 2013 13:50, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 12 September 2013 13:48, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>>>>  96      return ERR_PTR(-ENODATA);
>>
>> Wouldn't this be unconditional error return whether pdata is null or not?
>
> Stupid me... I meant return pdata from this place..
>
> Necessary checks are done in sdhci_probe()

sdhci_probe only checks for IS_ERR. We would need to change it to
IS_ERR_OR_NULL (which I do not prefer personally as there is some
discussion for its removal). In that case we would need to return as I
mentioned in my earlier email. Let me know your opinion.

-- 
With warm regards,
Sachin
