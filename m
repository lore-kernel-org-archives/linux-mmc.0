From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH/RFT] mmc: meson-gx: include tx phase in the tuning
 process
Date: Wed, 27 Sep 2017 18:24:20 +0200
Message-ID: <1506529460.16686.45.camel@baylibre.com>
References: <b31253d8-38a3-dd25-1d74-6afde6ae8362@gmail.com>
         <20170918134431.17520-1-jbrunet@baylibre.com>
         <3fd34a04-9a22-83e7-fb48-833b72bbea9f@gmail.com>
         <1505819337.2703.40.camel@baylibre.com>
         <d9c99f1e-bfe4-cdf7-bbfa-fc54837552e2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f173.google.com ([209.85.128.173]:56188 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751847AbdI0QYX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Sep 2017 12:24:23 -0400
Received: by mail-wr0-f173.google.com with SMTP id l39so17460826wrl.12
        for <linux-mmc@vger.kernel.org>; Wed, 27 Sep 2017 09:24:22 -0700 (PDT)
In-Reply-To: <d9c99f1e-bfe4-cdf7-bbfa-fc54837552e2@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org

On Tue, 2017-09-19 at 20:54 +0200, Heiner Kallweit wrote:
> > > Unfortunately this still doesn't fix the issue here.
> > > Tuning rx and tx clk sequentially assumes both are independent, what they
> > > IMHO are not. So meybe we have to check all combinations of rx/tx clk
> > > phase.
> > 
> > Interesting, I would be curious to know what tuning value you ended with,
> > compared to the "hard-coded' working value you have set.
> > 
> > You can get that fairly easily now, using CCF in debugfs, in
> > <debugfs>/clk/clk_summary, the different phase are reported
> > 
> 
> This gives me:
> 
> core phase: 180
> rx phase: 0
> tx phase: 270
> 
> And I end up with a corrupted root file system.

You should have had tuning on both the Rx and Tx phase and yet, you end up with
the default values ... that's strange

I should be able to get my hands on 16GB emmc module for this platform soon.
Let's see ...
