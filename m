From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: [PATCH v3 02/11] mmc: sdhci: set regulator min/max voltage
 according to spec
Date: Tue, 25 Sep 2012 23:46:51 +0800
Message-ID: <CADz5_gL--WDNndZzzLNU6n024=T1TPZ8m3mKhBheRG9dSNeziw@mail.gmail.com>
References: <1348569546-13242-1-git-send-email-keyuan.liu@gmail.com>
	<1348569546-13242-3-git-send-email-keyuan.liu@gmail.com>
	<CAGxe1ZGuUe3Z1hmUEGzkcRMmfyuQyZcoff_aTf=4ptqniFLE-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:35920 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726Ab2IYPqx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Sep 2012 11:46:53 -0400
Received: by wgbdr13 with SMTP id dr13so4850214wgb.1
        for <linux-mmc@vger.kernel.org>; Tue, 25 Sep 2012 08:46:51 -0700 (PDT)
In-Reply-To: <CAGxe1ZGuUe3Z1hmUEGzkcRMmfyuQyZcoff_aTf=4ptqniFLE-w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com, hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com, Jialing Fu <jlfu@marvell.com>

2012/9/25 Girish K S <girish.shivananjappa@linaro.org>:
> On 25 September 2012 19:38, Kevin Liu <keyuan.liu@gmail.com> wrote:
>> From: Kevin Liu <kliu5@marvell.com>
>>
>> Use voltage range as below rather than a specific value
>> 3.3v: (3.2v, 3.4v)
>> 3.0v: (2.9v, 3.1v)
>> 1.8v: (1.65v, 1.95v)
> Any specific reason to give range and not specific value?

Regulator voltage setting with specific value may fail if the
regulator didn't support the specific voltage. But the range should be
acceptable according to the spec.

Thanks
Kevin
