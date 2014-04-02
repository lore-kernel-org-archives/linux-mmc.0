From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH RESEND] mmc: sdhci-s3c: Remove unused define for NUM_GPIOS
Date: Wed, 2 Apr 2014 08:29:11 +0800
Message-ID: <CAFRkauB=E+9JrKqZ2ZoFGwPhgnD41sahPAg15r=NwHV=3Q_Y_A@mail.gmail.com>
References: <1394262224.3868.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:46065 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757061AbaDBA3M (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Apr 2014 20:29:12 -0400
Received: by mail-qg0-f44.google.com with SMTP id a108so9997844qge.31
        for <linux-mmc@vger.kernel.org>; Tue, 01 Apr 2014 17:29:11 -0700 (PDT)
In-Reply-To: <1394262224.3868.1.camel@phoenix>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: Thomas Abraham <thomas.abraham@linaro.org>, linux-mmc@vger.kernel.org

2014-03-08 15:03 GMT+08:00 Axel Lin <axel.lin@ingics.com>:
> NUM_GPIOS is not used after commit e19499ae
> "mmc: sdhci-s3c: let device core setup the default pin configuration".
> Thus remove it.

Hi Chris,
Would you pick up this patch?

Regards,
Axel
