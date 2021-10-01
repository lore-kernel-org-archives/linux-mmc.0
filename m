Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290E1C433F5
	for <linux-mmc@archiver.kernel.org>; Fri,  1 Oct 2021 09:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06D5961A57
	for <linux-mmc@archiver.kernel.org>; Fri,  1 Oct 2021 09:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353064AbhJAJht (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 1 Oct 2021 05:37:49 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:47068 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352915AbhJAJht (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Oct 2021 05:37:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633080965; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=BeCtPj+gAx1yb+qr7Piiqq97L5UNvZlh+6GnVLGIR9Q=; b=ngIOHp/xnpkNK9dJFbTE1+SSwJG/n9pqzhohZ669Td8nuvj9hwYYYiC0YyruY6h/F33k0NpF
 KRT0/FBI80e75msfcAYQ1UX978iTdgKermxzaDjJD7/JZ+UmfV9p+MPo6AVFVnG1j/acJCQG
 2njHA8dcEtNo2MH5gug8XvP+m3Q=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 6156d66947d64efb6dd25f1f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 01 Oct 2021 09:35:37
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 399F7C4338F; Fri,  1 Oct 2021 09:35:37 +0000 (UTC)
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B05F2C4338F;
        Fri,  1 Oct 2021 09:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org B05F2C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Jerome Pouiller <Jerome.Pouiller@silabs.com>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-mmc@vger.kernel.org,
        Pali =?utf-8?Q?Roh?= =?utf-8?Q?=C3=A1r?= <pali@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v7 20/24] wfx: add scan.c/scan.h
References: <20210920161136.2398632-1-Jerome.Pouiller@silabs.com>
        <20210920161136.2398632-21-Jerome.Pouiller@silabs.com>
Date:   Fri, 01 Oct 2021 12:35:28 +0300
In-Reply-To: <20210920161136.2398632-21-Jerome.Pouiller@silabs.com> (Jerome
        Pouiller's message of "Mon, 20 Sep 2021 18:11:32 +0200")
Message-ID: <87r1d5krz3.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Jerome Pouiller <Jerome.Pouiller@silabs.com> writes:

> From: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
>
> Signed-off-by: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>

[...]

> +/* It is not really necessary to run scan request asynchronously. Howeve=
r,
> + * there is a bug in "iw scan" when ieee80211_scan_completed() is called=
 before
> + * wfx_hw_scan() return
> + */
> +void wfx_hw_scan_work(struct work_struct *work)
> +{
> +	struct wfx_vif *wvif =3D container_of(work, struct wfx_vif, scan_work);
> +	struct ieee80211_scan_request *hw_req =3D wvif->scan_req;
> +	int chan_cur, ret, err;
> +
> +	mutex_lock(&wvif->wdev->conf_mutex);
> +	mutex_lock(&wvif->scan_lock);
> +	if (wvif->join_in_progress) {
> +		dev_info(wvif->wdev->dev, "abort in-progress REQ_JOIN");
> +		wfx_reset(wvif);
> +	}
> +	update_probe_tmpl(wvif, &hw_req->req);
> +	chan_cur =3D 0;
> +	err =3D 0;
> +	do {
> +		ret =3D send_scan_req(wvif, &hw_req->req, chan_cur);
> +		if (ret > 0) {
> +			chan_cur +=3D ret;
> +			err =3D 0;
> +		}
> +		if (!ret)
> +			err++;
> +		if (err > 2) {
> +			dev_err(wvif->wdev->dev, "scan has not been able to start\n");
> +			ret =3D -ETIMEDOUT;
> +		}
> +	} while (ret >=3D 0 && chan_cur < hw_req->req.n_channels);
> +	mutex_unlock(&wvif->scan_lock);
> +	mutex_unlock(&wvif->wdev->conf_mutex);
> +	__ieee80211_scan_completed_compat(wvif->wdev->hw, ret < 0);
> +}
> +
> +int wfx_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
> +		struct ieee80211_scan_request *hw_req)
> +{
> +	struct wfx_vif *wvif =3D (struct wfx_vif *)vif->drv_priv;
> +
> +	WARN_ON(hw_req->req.n_channels > HIF_API_MAX_NB_CHANNELS);
> +	wvif->scan_req =3D hw_req;
> +	schedule_work(&wvif->scan_work);
> +	return 0;
> +}

This scan logic looks fishy to me, but no time to investigate in detail.
Though not a blocker.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
