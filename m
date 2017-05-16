From: Fabio Estevam <festevam@gmail.com>
Subject: Re: imx7: mmc_select_hs200 failed, error -74
Date: Tue, 16 May 2017 14:57:52 -0300
Message-ID: <CAOMZO5Ddz4v80BvU0h9O04UBdVWUpr5po=p+MOhgk1skOhqvwA@mail.gmail.com>
References: <CAOMZO5ByTR1C4qUdc+hBcGTFVf-NH2gS5PmH3=w5-TrAoDQVUA@mail.gmail.com>
 <CAOMZO5AXb3-YGc7hGRP_OY8C-Go0pBECbDoQo1SUB1i=t1Xi4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:35971 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751645AbdEPR5x (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 May 2017 13:57:53 -0400
Received: by mail-oi0-f44.google.com with SMTP id h4so35255331oib.3
        for <linux-mmc@vger.kernel.org>; Tue, 16 May 2017 10:57:53 -0700 (PDT)
In-Reply-To: <CAOMZO5AXb3-YGc7hGRP_OY8C-Go0pBECbDoQo1SUB1i=t1Xi4w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <aisheng.dong@nxp.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Stefan Agner <stefan@agner.ch>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, May 16, 2017 at 12:37 PM, Fabio Estevam <festevam@gmail.com> wrote:

> Is this a correct fix?

This does not seem correct. I will submit a proper patch.
