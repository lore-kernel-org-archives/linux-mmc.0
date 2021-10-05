Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B459C433F5
	for <linux-mmc@archiver.kernel.org>; Tue,  5 Oct 2021 06:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B58861139
	for <linux-mmc@archiver.kernel.org>; Tue,  5 Oct 2021 06:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhJEGOm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 5 Oct 2021 02:14:42 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:29854 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbhJEGOl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Oct 2021 02:14:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633414372; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=+xbESTP4kkiGyu41HaCLG8ls13YPmSv1/s4uk3OzTP4=; b=tw10qUZKwx7UTHUgD5VsaBJSxROO2jmDBbQmBuLY/90HheTp4TGEVwxoWdiWE82E6rxsUz/Q
 UwQ7hRXvVXRDUpXhGHmpBqul/nnqmFp6BOlML/sBK4OJ/Mcz6CB112gVqhsPa/9EJRUvGLzd
 OdtECb02rRJFe2fqhVlN9RV3GhE=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 615becd49ffb41314998b028 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 05 Oct 2021 06:12:36
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E4D8AC43460; Tue,  5 Oct 2021 06:12:35 +0000 (UTC)
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E4385C4338F;
        Tue,  5 Oct 2021 06:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org E4385C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Cc:     =?utf-8?B?SsOpcsO0bWU=?= Pouiller <jerome.pouiller@silabs.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v7 13/24] wfx: add hif_tx*.c/hif_tx*.h
References: <20210920161136.2398632-1-Jerome.Pouiller@silabs.com>
        <20210920161136.2398632-14-Jerome.Pouiller@silabs.com>
        <87fstlkr1m.fsf@codeaurora.org> <2873071.CAOYYqaKbK@pc-42>
        <20211001161316.w3cwsigacznjbowl@pali>
Date:   Tue, 05 Oct 2021 09:12:27 +0300
In-Reply-To: <20211001161316.w3cwsigacznjbowl@pali> ("Pali \=\?utf-8\?Q\?Roh\?\=
 \=\?utf-8\?Q\?\=C3\=A1r\=22's\?\= message of
        "Fri, 1 Oct 2021 18:13:16 +0200")
Message-ID: <87tuhwf19w.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:

> On Friday 01 October 2021 17:17:52 J=C3=A9r=C3=B4me Pouiller wrote:
>> On Friday 1 October 2021 11:55:33 CEST Kalle Valo wrote:
>> > CAUTION: This email originated from outside of the organization.
>> > Do not click links or open attachments unless you recognize the
>> > sender and know the content is safe.
>> >=20
>> >=20
>> > Jerome Pouiller <Jerome.Pouiller@silabs.com> writes:
>> >=20
>> > > From: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
>> > >
>> > > Signed-off-by: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
>> >=20
>> > [...]
>> >=20
>> > > --- /dev/null
>> > > +++ b/drivers/net/wireless/silabs/wfx/hif_tx_mib.h
>> > > @@ -0,0 +1,49 @@
>> > > +/* SPDX-License-Identifier: GPL-2.0-only */
>> > > +/*
>> > > + * Implementation of the host-to-chip MIBs of the hardware API.
>> > > + *
>> > > + * Copyright (c) 2017-2020, Silicon Laboratories, Inc.
>> > > + * Copyright (c) 2010, ST-Ericsson
>> > > + * Copyright (C) 2010, ST-Ericsson SA
>> > > + */
>> > > +#ifndef WFX_HIF_TX_MIB_H
>> > > +#define WFX_HIF_TX_MIB_H
>> > > +
>> > > +struct wfx_vif;
>> > > +struct sk_buff;
>> > > +
>> > > +int hif_set_output_power(struct wfx_vif *wvif, int val);
>> > > +int hif_set_beacon_wakeup_period(struct wfx_vif *wvif,
>> > > +                              unsigned int dtim_interval,
>> > > +                              unsigned int listen_interval);
>> > > +int hif_set_rcpi_rssi_threshold(struct wfx_vif *wvif,
>> > > +                             int rssi_thold, int rssi_hyst);
>> > > +int hif_get_counters_table(struct wfx_dev *wdev, int vif_id,
>> > > +                        struct hif_mib_extended_count_table *arg);
>> > > +int hif_set_macaddr(struct wfx_vif *wvif, u8 *mac);
>> > > +int hif_set_rx_filter(struct wfx_vif *wvif,
>> > > +                   bool filter_bssid, bool fwd_probe_req);
>> > > +int hif_set_beacon_filter_table(struct wfx_vif *wvif, int tbl_len,
>> > > +                             const struct hif_ie_table_entry *tbl);
>> > > +int hif_beacon_filter_control(struct wfx_vif *wvif,
>> > > +                           int enable, int beacon_count);
>> > > +int hif_set_operational_mode(struct wfx_dev *wdev, enum
>> > > hif_op_power_mode mode);
>> > > +int hif_set_template_frame(struct wfx_vif *wvif, struct sk_buff *sk=
b,
>> > > +                        u8 frame_type, int init_rate);
>> > > +int hif_set_mfp(struct wfx_vif *wvif, bool capable, bool required);
>> > > +int hif_set_block_ack_policy(struct wfx_vif *wvif,
>> > > +                          u8 tx_tid_policy, u8 rx_tid_policy);
>> > > +int hif_set_association_mode(struct wfx_vif *wvif, int ampdu_densit=
y,
>> > > +                          bool greenfield, bool short_preamble);
>> > > +int hif_set_tx_rate_retry_policy(struct wfx_vif *wvif,
>> > > +                              int policy_index, u8 *rates);
>> > > +int hif_keep_alive_period(struct wfx_vif *wvif, int period);
>> > > +int hif_set_arp_ipv4_filter(struct wfx_vif *wvif, int idx, __be32 *=
addr);
>> > > +int hif_use_multi_tx_conf(struct wfx_dev *wdev, bool enable);
>> > > +int hif_set_uapsd_info(struct wfx_vif *wvif, unsigned long val);
>> > > +int hif_erp_use_protection(struct wfx_vif *wvif, bool enable);
>> > > +int hif_slot_time(struct wfx_vif *wvif, int val);
>> > > +int hif_wep_default_key_id(struct wfx_vif *wvif, int val);
>> > > +int hif_rts_threshold(struct wfx_vif *wvif, int val);
>> >=20
>> > "wfx_" prefix missing from quite a few functions.
>>=20
>> I didn't know it was mandatory to prefix all the functions with the
>> same prefix.

I don't know either if this is mandatory or not, for example I do not
have any recollection what Linus and other maintainers think of this. I
just personally think it's good practise to use driver prefix ("wfx_")
in all non-static functions.

Any opinions from others? Greg?

>> With the rule of 80-columns, I think I will have to change a bunch of
>> code :( .
>
> I think that new drivers can use 100 characters per line.

That's my understanding as well.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
