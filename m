Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834F8C433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 30 May 2022 12:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbiE3M1O (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 May 2022 08:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbiE3M1O (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 May 2022 08:27:14 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F811C919
        for <linux-mmc@vger.kernel.org>; Mon, 30 May 2022 05:27:12 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id i11so18754575ybq.9
        for <linux-mmc@vger.kernel.org>; Mon, 30 May 2022 05:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p4fLmQAR2zXvVx2pt6LdiS0s7dwViUlVOXE8x3nuHkE=;
        b=kFMzaegjuccUW6X3vFVK51uxM80VK6RlJ+hhjQlcPL4lGAoRpWLXT46MDFFp/ihvLk
         +6cR6k1cAM2hMMfAcpZy7oFkyUA2usQu3Vi1pGwWgaXUFaZOtu9Fq017dWOWwfUsv8Qz
         3n8LQ8c3rMEqpzCmj/0w2UBapxUAiorpBk5Jze5UsKY1uvR4/Zn6ZyvhLMkRbAIUYptr
         LPJC8sesj2rE46NJdYSG6PSn/Ye4+tnxrKiJqO7RdowS6b7EYXLbZyyBh+zDAKWIzL4J
         bF8VHjJJbbhAOZtWgLA+HUdTYXrTzhAvKYTqtb+eHsUhWgPYuw9L63S164s8LhZwIoo4
         V96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p4fLmQAR2zXvVx2pt6LdiS0s7dwViUlVOXE8x3nuHkE=;
        b=PEwFYWDCbEX6yJOIXeoK9K1erJz4al4PldJO9vzH/lBwEZe1hwnZxv0c/geG98XV3Z
         nlQEH+LIJ782zajBx4H0M/hm1itBq6SeP3Oop3ZhMamOZ5lDVmYqWRFXyltvFh3JftVP
         J7pIxl8aLPygpV2F8wcGCi6iEun3JfL94sZBdz7BwuNC5YAwGFFwRX6Fv08TapBjyhf0
         34hhj4YLgzFThvjhAkFDgB4zOCiUjrDH4DEXRj96ks5wDuiqCyxy5uGczvdn/2ASO0L6
         bERdImEcVuHvjRqCQDLMh3ZjZ8OHFflj004iKgBQ9JauopiF7SsUjNrtJnyC4WMkNYk5
         ejDQ==
X-Gm-Message-State: AOAM531d8p9qAqVm/g6WCg9O7quXZLb6oj7IpvErqvBBSICTN6qxPk61
        COZSzDfsSZBw0hxn26PL3V2R8DQ4k/429LrY7+gvofMPY18=
X-Google-Smtp-Source: ABdhPJyg0LNI2e57TV5PI249TKaQgg4EbMTL8g0W3k9NP3nHnBc8LJ3wrrVoNByYfKZobnrJDojtCLyJmzzsSR2w+Io=
X-Received: by 2002:a5b:a4f:0:b0:65c:a9c2:dc96 with SMTP id
 z15-20020a5b0a4f000000b0065ca9c2dc96mr9983327ybq.18.1653913632072; Mon, 30
 May 2022 05:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220530084702.64943-1-jasonlai.genesyslogic@gmail.com> <59ad4f41eeeb4d5cbc4859e59ae2ef26@hyperstone.com>
In-Reply-To: <59ad4f41eeeb4d5cbc4859e59ae2ef26@hyperstone.com>
From:   Lai Jason <jasonlai.genesyslogic@gmail.com>
Date:   Mon, 30 May 2022 20:27:01 +0800
Message-ID: <CAG0XXUGginXkF8t2=psJ8iPTu4=0d-97BfsWHv-rO6AahvchsQ@mail.gmail.com>
Subject: Re: [V2] mmc: sdhci-pci-gli: Improve Random 4K Read Performance of GL9763E
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "ben.chuang@genesyslogic.com.tw" <ben.chuang@genesyslogic.com.tw>,
        "greg.tu@genesyslogic.com.tw" <greg.tu@genesyslogic.com.tw>,
        "SeanHY.chen@genesyslogic.com.tw" <SeanHY.chen@genesyslogic.com.tw>,
        "jason.lai@genesyslogic.com.tw" <jason.lai@genesyslogic.com.tw>,
        "victor.shih@genesyslogic.com.tw" <victor.shih@genesyslogic.com.tw>,
        Renius Chen <reniuschengl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, May 30, 2022 at 5:03 PM Christian L=C3=B6hle <CLoehle@hyperstone.co=
m> wrote:
>
> >This patch is based on patch [1] and adopt Adrian's comment.
> >
> >Due to flaws in hardware design, GL9763E takes long time to exit from L1
> >state. The I/O performance will suffer severe impact if it often enter
> >and exit L1 state.
> >
> >Unfortunately, entering and exiting L1 state is signal handshake in
> >physical layer, software knows nothiong about it. The only way to stop
> >entering L1 state is to disable hardware LPM negotiation on GL9763E.
> >
> >To improve read performance and take battery life into account, we rejec=
t
> >L1 negotiation while executing MMC_READ_MULTIPLE_BLOCK command and enabl=
e
> >L1 negotiation again when receiving non-MMC_READ_MULTIPLE_BLOCK command.
> >
>
> Could you describe the impact for people unfamilar with the GL9763E?
> Does this essientially disable low-power mode if the controller serviced =
a CMD18 last?
> (which will be most of the (idle) time for reasonable scenarios, right?)
> Or what exactly is the LPM negotation doing?=3D
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>

The I/O request flow can be simplified as below:
        request received --> mmc_command --> wait command
complete(data transfer phase)
        --> request complete --> wait-for-next-request
If the time interval between 2 stages exceeds L1 entry delay time(21
us for GL9763E), PCIe
LINK layer will enter L1 state and kernel/driver cannot know when it
occurred. When PCIe
host is going to send message/command, its LINK will exit L1 state
first. GL9763E also exits
L1 state simultaneously, but it takes a little time to get back to L0
state. If we let GL9763E
enter and exit L1 state freely, only 20% of read performance remains.
Hence, we decide to
disable LPM negotiation during READ_MULTIPLE_BLOCK command.

Considering that the PCIe LINK will also enter L1 state during
wait-for-next-request stage,
LPM negotiation also needs to be disabled in this stage. That's why we
enable/disable LPM
negotiation at the point which request received. I give an example as follo=
ws=EF=BC=9A
        CMD18 --> disable LPM negotiation --> CMD18 done
        --> CMD18 --> keep LPM negotiation disabled --> CMD18 done
        --> CMD17 --> enable LPM negotiation --> CMD17 done
        --> CMD17 --> keep LPM negotiation enabled --> CMD17 done
        --> CMD18 --> disable LPM negotiation --> CMD18 done

Hope the explanation above can answer your question.

regards,
Jason Lai
