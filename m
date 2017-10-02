From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH/RFT] mmc: meson-gx: include tx phase in the tuning
 process
Date: Mon, 02 Oct 2017 14:30:11 +0200
Message-ID: <1506947411.17300.17.camel@baylibre.com>
References: <b31253d8-38a3-dd25-1d74-6afde6ae8362@gmail.com>
         <20170918134431.17520-1-jbrunet@baylibre.com>
         <3fd34a04-9a22-83e7-fb48-833b72bbea9f@gmail.com>
         <1505819337.2703.40.camel@baylibre.com>
         <d9c99f1e-bfe4-cdf7-bbfa-fc54837552e2@gmail.com>
         <1506529460.16686.45.camel@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:56947 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751398AbdJBMaP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Oct 2017 08:30:15 -0400
Received: by mail-wm0-f41.google.com with SMTP id e195so6490701wma.5
        for <linux-mmc@vger.kernel.org>; Mon, 02 Oct 2017 05:30:14 -0700 (PDT)
In-Reply-To: <1506529460.16686.45.camel@baylibre.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org

On Wed, 2017-09-27 at 18:24 +0200, Jerome Brunet wrote:
> On Tue, 2017-09-19 at 20:54 +0200, Heiner Kallweit wrote:
> > > > Unfortunately this still doesn't fix the issue here.
> > > > Tuning rx and tx clk sequentially assumes both are independent, what
> > > > they
> > > > IMHO are not. So meybe we have to check all combinations of rx/tx clk
> > > > phase.
> > > 
> > > Interesting, I would be curious to know what tuning value you ended with,
> > > compared to the "hard-coded' working value you have set.
> > > 
> > > You can get that fairly easily now, using CCF in debugfs, in
> > > <debugfs>/clk/clk_summary, the different phase are reported
> > > 
> > 
> > This gives me:
> > 
> > core phase: 180
> > rx phase: 0
> > tx phase: 270
> > 
> > And I end up with a corrupted root file system.
> 
> You should have had tuning on both the Rx and Tx phase and yet, you end up
> with
> the default values ... that's strange
> 
> I should be able to get my hands on 16GB emmc module for this platform soon.
> Let's see ...


So, I did some tests on the odroidc2 with the 16GB emmc module.

1) With Mainline + DTS patches (Waiting in Olof late branch) + the patch
proposed here:

mmc0: new HS200 MMC card at address 0001
mmcblk0: mmc0:0001 SDW16G 14.7 GiB
mmcblk0boot0: mmc0:0001 SDW16G partition 1 4.00 MiB
mmcblk0boot1: mmc0:0001 SDW16G partition 2 4.00 MiB
mmcblk0rpmb: mmc0:0001 SDW16G partition 3 4.00 MiB
mmcblk0: p1 p2 p3 p4

and clk_summary

d0074000.mmc#mux     1            1  1000000000          0 0
 d0074000.mmc#div    1            1   200000000          0 0
  d0074000.mmc#core  1            1   200000000          0 180
  d0074000.mmc#rx    0            0   200000000          0 120
  d0074000.mmc#tx    0            0   200000000          0 0

Note the tx phase tuning ended-up with the value you expected. I've done read
tests with this and there was no issue.

This made no sense with the value you reported but I thought maybe you did your
test in hs400 ... so I tested and it seems to be the case. In this mode, the
tuning value got reset.

This is because I mistakenly place the phase reset in POWER_ON instead of
POWER_UP.
The phase get reset every time the set_ios() is called, which is not what we
want.

With a few fix applied here, this is what I get:

# cat /sys/kernel/debug/mmc0/ios       
clock:          200000000 Hz           
actual clock:   166666667 Hz           
vdd:            21 (3.3 ~ 3.4 V)       
bus mode:       2 (push-pull)          
chip select:    0 (don't care)         
power mode:     2 (on)                 
bus width:      3 (8 bits)             
timing spec:    10 (mmc HS400)         
signal voltage: 1 (1.80 V)             
driver type:    0 (driver type B)      

clk_summary:
d0074000.mmc#mux            1            1  1000000000          0 0
 d0074000.mmc#div           1            1   333333334          0 0
  d0074000.mmc#core         1            1   333333334          0 180
  d0074000.mmc#rx           0            0   333333334          0 120
  d0074000.mmc#tx           0            0   333333334          0 0

No errors reported while doing read test using dd. Read throughput appears to be
around 220MB/s with this module.

I have posted a series with the fixes here:
https://lkml.kernel.org/r/20171002122743.32334-1-jbrunet@baylibre.com

Jerome.


