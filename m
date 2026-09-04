Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB84D468C15
	for <linux-mmc@vger.kernel.org>; Fri,  4 Sep 2026 09:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514930; cv=pass; b=WxeLGYMgMLL7+ZkEG7wn745JqHuQdVt+h/Nqjsp2VtFbY+bEFmB5kyvO3Dbz6znFO3vQgtvLnsK4vJxDvA8T1+Ridj7eOkeGdnXklzbwt6RpaW5FUj0K+fd/OtxtyDSJhJzIgLDGdj9gVbEZCvg3s1VUYjQYzJIeRFDr3bcwkx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514930; c=relaxed/simple;
	bh=gtS9Eh8JvepUW11uBQYJSAcuu6QMCZChXkRm8+p5ZZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DdsPY4e+yn1siK3USKiEIq2QRvQQ7MG0yn2lDOuDP5GLWLJTbuglJIF2JQh12GPYU0BuJjnoDfR80GZeJdRrZcYZn+J8Q3r536uyGIAxE8bpBPNnrlMw700maNVfUpnrcenSImHbab3W7FKYvlDwgOjPnzoIBqglRPpCp6fWnGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FK1qTl/v; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PARJKESE; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FK1qTl/v";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PARJKESE"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6847n4SQ2976906
	for <linux-mmc@vger.kernel.org>; Fri, 4 Sep 2026 09:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T0ABrV+8A+UI+7WYrysuHa3cc9K45HFJBZ2lWEJ3Wvk=; b=FK1qTl/vzWRenfsY
	ffU/ZWPTWgkupp1V1DnnRZXGeG1FxXfi/l7IE8DED5zzgiTgW49NgltUvyhoTFgX
	Q62VvrK4mz4jw1skYVNqUWhvLNxKBXVwFZVNPrUuHhZ32KlkknGZuFU4BLRtGcQd
	YbR6CsNGIlp5GMuuZV/xyDPhjLV+b3fGzXi53W2rqQQl+qdyEOioeeGq4Yucq6N2
	KV74U66K70BJHL/mNqi4kb2P/LQqgg2a6ImqFA/0Orup3Q6N4e2dF+kRppLiiNSJ
	bydhF0ZvPPG637XDm2fmZ5gyx82p5qesLLhFhd5QKwn1JM2XhC0cMNu//4XRtq/R
	C4YSgw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfdyxjxut-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 04 Sep 2026 09:42:06 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-396901263b6so1589148a91.2
        for <linux-mmc@vger.kernel.org>; Fri, 04 Sep 2026 02:42:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788514925; cv=none;
        d=google.com; s=arc-20260327;
        b=Vj2FO8xvn0CR3rK064Uek9jaaiOIFcQTxzR4RjzDQQgo8x54F7/LK0g/vRYcQsFesc
         7YY27FueLGtjpLbCbBzcs+QdyC8BIZSrIqXD4wxTr5jDJsPHG5KuppOmkc5w/jFeUNYz
         dzk3L91U2OijMqxL5esIdruVU6HroUY9assXaM0sNNlf1VoIer8vV8RiQswZUwprzlPi
         B/qHOSwbiaELbvmUfWRQm+bHj97QNHF59fJGTJerom7PV6xp+ymfcs9fjVIj3lDnj7TG
         fdzgmXgwXzRY/t7B2ZlfeScaJ0DmspjE0RtZYM/d/8h4YzXEM4oCSeG5eBsGR0S4hLbF
         PMXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T0ABrV+8A+UI+7WYrysuHa3cc9K45HFJBZ2lWEJ3Wvk=;
        fh=/9zYQDMjZmhbEODQbqhvw0wYyAYP/IVAWy8/z2RidGA=;
        b=oiBJZ2wsZMQ1QkWEwVZsWIVIjWXa2EU8SndYaABdHt2jc9l9whVqdNKnUl1c7tP3P2
         qYcJkA24JhIlbGUOvwcirlpqrfchdMb+93Yk2YXqH6qyrTrQ/JpA0GrdN3zjIU1174mZ
         WNyaw0Hb48v1v00582CoY0hMdGG7FzmldDkouC1/jWlw4iZx7bFIBZna4RNSh2ZcVP70
         u34sJqnN/hctfM+zh9apZUARZ3T79u/jglE6ntmQoMDQSji0urRTdk6whHIAvKgJ2dSR
         95dnx9CUg0PsTylvLxj+tYr3WHWMwgTt+UmZTsV5TODmKQF7JfIx04TvD3KfV3Fbq6Zl
         17Qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788514925; x=1789119725; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T0ABrV+8A+UI+7WYrysuHa3cc9K45HFJBZ2lWEJ3Wvk=;
        b=PARJKESEFvIYA2jsOmLcU8XgZ0M2mboEysh6KGycIYyFQG2nEhPh1jtMjnsoXmBMhc
         8UApHhYcOdOLhv/4Q5eo+iDXz4ZIgsNk7cy9EBFLqkpERBesywbIXynD0iytRCr8KoRM
         54zatlOMAdxw4Eq9oF3ZS1+b35e6BQGL6Yypoglm8zKAYbVVwiX2S+iAMFpV4hmFX6XE
         PUI6DIv7lxRwj9I0jO+j6y76NF8pVoiS2Sk0hUKRNdbUui9t3pxGZEBJLDOWzvSQZd0m
         jA9n0BMwaEgBDDAqZEkLYK8Y2lUWorMAQEWv5AvIQ/k+Y27g0yH3CvnptqhMVPt0NYkW
         YXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788514925; x=1789119725;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T0ABrV+8A+UI+7WYrysuHa3cc9K45HFJBZ2lWEJ3Wvk=;
        b=ELRTcQTAXCtyfigxAIGzKZQbRgC2Xoo/lF1qpXC/KUFj88+l/LdzRn00UsdI+XbCiV
         IYS/JnjAFSzmudUNvu8P+didWnNd//tjmafq8R1UdmA7AbHsBNLhgpG1o5zJg34BRsfY
         NnoxhZAKJOWYH3hPRuqtFfPbCFYCdbSH/IJsPcmdDhJJe7LPh5AZ66aDEMQKTBQCUa6Y
         MpuS2nMID7PpNGZbmLMUwd8LjGTQ3mjXHW0QyV/hqGHFGYuiZWfv9BiR4SzSJOl4/Reg
         BMnAvCKhSOGXSTI72kDlSeN7XW8b+bPuFElzWNkme92F5/dJni+V+p5sooJgxlZkbbqj
         O5kw==
X-Gm-Message-State: AFuF++nWc7P0FCEXj34o6OwQdMEXw1MHamgKm7BOqnhNUAeA75i3r7oH
	FHbvEjBC/wYWjwTJlJA27xxH5rPKaTssvtMNJ3lXqTLhc/CjIThZfq263Jt9qwrpM6461M0Fog6
	BQOTMuX48ljn2C4vUr5XmGMSMERxm7SoNizFZaOranuLoZf6kM9ANIAvP5PYwf1UcgkwWej5e2T
	fa/rP4p7bhwcIKOyAPgq/NeYAADOYyWxNFql926w==
X-Gm-Gg: AYBFou0xjTMsUXrhM9NQjuBSQVG8SeNEzRB5woDEiy/qTmFiomEaB0tjGYWqKV6GzVv
	Cfaq4opt6HQf0pH6y5rP5dRhHosAczJab54LPdS4zWcTieCjq3JH8lso52uO7qZlNacUEm7blD0
	Qnt2qLITJ4QgD0MgJARpKsfw0yHGTob8nxDp+VK7n17ombiOYt1DaGggqkFg==
X-Received: by 2002:a17:90b:2b43:b0:38e:c7b0:84ad with SMTP id 98e67ed59e1d1-39b25ed34f3mr8753733a91.0.1788514925390;
        Fri, 04 Sep 2026 02:42:05 -0700 (PDT)
X-Received: by 2002:a17:90b:2b43:b0:38e:c7b0:84ad with SMTP id
 98e67ed59e1d1-39b25ed34f3mr8753668a91.0.1788514924865; Fri, 04 Sep 2026
 02:42:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810153734.139186-1-torsteine+linux@gmail.com>
In-Reply-To: <20260810153734.139186-1-torsteine+linux@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 11:41:53 +0200
X-Gm-Features: AcwNN1VOxCZBAvlQTELpQcShFjVh2It-FWH15mqsvZp-o5-Jq_Uk_tc8UUBj63U
Message-ID: <CAPx+jO_sY0Tz4HAcFMis06y7q8HtZfLGu_G2GMqoqySNhd_4Ow@mail.gmail.com>
Subject: Re: [PATCH v2] mmc-utils: Add bash completion
To: Torstein Eide <torsteine+linux@gmail.com>
Cc: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: PiqRABwGH3YDiEmgnMIsdTTlvYZ_Lo3e
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4OCBTYWx0ZWRfX6xmmA8/VG74k
 37kiirmHIHd0zpxPoVCd/q1cEVZUPA5DkuLRuxb3dCEh9aaTnlcq7/o2aU2do2ZqVXangKyo2ED
 yVeBRTPv7bqKe+9jgxOhIol6qHb3v2w=
X-Proofpoint-GUID: PiqRABwGH3YDiEmgnMIsdTTlvYZ_Lo3e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4OCBTYWx0ZWRfXymLepYJ9Ugw9
 k5kJrv+gULUxQfjwDpU/oxqswloMoQRDTcqcSdVZM82Ve2g+KIBUrv4UNK/m7O5dLl2u35cfFPi
 h39Bcj5zSj/4msCOYnCotJBLFmIFYA/HPa4pWMi06OuqMT9s8KqzkJRONst8tOpWqtWPhRpbnht
 Xrn2bOnM0VIz66LLchBFwQeeWbnS55QzPOyNGu9hJWenS7RDYMCCVWdQH665mPvmaAKN5FqQThc
 tGrOiciKOXJv13Au0/cFeWSox2b2UaYe79WOF8F4AKu6BWeiauHR01xMh6yDqqxm/6RpWhSKJaa
 j/oZtOSBpgfqDooiFd7efNiwe1Dgx+OOyYHZ89SpPanWkJgMHyBnVqOo7YxlMaAxBgvMGP+EKVF
 U8+0uomW90Y0QbvXJHFzKuMYzOaKCqYzOzem7zJDrwajL0lw5zbvConJFFdm2S3t0tGC4OxdMQh
 2UaPNePfkhJag5sAQlw==
X-Authority-Analysis: v=2.4 cv=X9Zi7mTe c=1 sm=1 tr=0 ts=6a9a926e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=pGLkceISAAAA:8 a=20Y1CySOYr8P52152LIA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040088

On Mon, Aug 10, 2026 at 5:37=E2=80=AFPM Torstein Eide <torsteine+linux@gmai=
l.com> wrote:
>
> Add a bash completion script in completion/mmc that completes subcommands
> and /dev/mmcblkN device paths for all mmc commands.
>
> Subcommand completion is driven by parsing 'mmc help' output rather than
> maintaining a parallel hardcoded verb list, so it stays in sync as
> commands are added or removed.
>
> The completion directory is named 'completion/' rather than
> 'bash-completion/' so shell-specific scripts for other shells (zsh,
> fish, etc.) can be placed alongside it without renaming.
>
> Add bashcompletiondir variable to the Makefile (defaulting to the
> standard /usr/share/bash-completion/completions) and install the
> script as part of 'make install'. The install path can be overridden
> at build time with make bashcompletiondir=3D<path>.
>
> Signed-off-by: Torstein Eide <torsteine+linux@gmail.com>

Applied for mmc-utils master, thanks!

Kind regards
Uffe


> ---
> Changes since v1:
> - Makefile: use 'bashcompletiondir ?=3D' instead of '=3D'.
> - completion/mmc: match rpmb, bootN, and partition device nodes in
>   addition to the base mmcblkN device.
>
>  Makefile       |  3 +++
>  completion/mmc | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  docs/HOWTO.rst |  6 ++++++
>  3 files changed, 63 insertions(+)
>  create mode 100644 completion/mmc
>
> diff --git a/Makefile b/Makefile
> index bf8c006..6eb584b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -7,6 +7,7 @@ AM_CFLAGS =3D -D_FILE_OFFSET_BITS=3D64 -D_FORTIFY_SOURCE=
=3D2 \
>             -DSD_IDS_PATH=3D\"$(idsdir)/sdcard.ids\" \
>             -DMMC_IDS_PATH=3D\"$(idsdir)/multimediacard.ids\"
>  CFLAGS ?=3D -g -O2
> +bashcompletiondir ?=3D /usr/share/bash-completion/completions
>  objects =3D \
>         mmc.o \
>         mmc_cmds.o \
> @@ -63,6 +64,8 @@ install: $(progs)
>         $(INSTALL) -m755 -d $(DESTDIR)$(idsdir)
>         $(INSTALL) -m 644 sdcard.ids $(DESTDIR)$(idsdir)
>         $(INSTALL) -m 644 multimediacard.ids $(DESTDIR)$(idsdir)
> +       $(INSTALL) -m755 -d $(DESTDIR)$(bashcompletiondir)
> +       $(INSTALL) -m 644 completion/mmc $(DESTDIR)$(bashcompletiondir)/m=
mc
>
>  -include $(foreach obj,$(objects), $(dir $(obj))/.$(notdir $(obj)).d)
>
> diff --git a/completion/mmc b/completion/mmc
> new file mode 100644
> index 0000000..1ac053b
> --- /dev/null
> +++ b/completion/mmc
> @@ -0,0 +1,54 @@
> +_mmc_complete() {
> +       local cur prev words cword
> +       _init_completion || return
> +
> +       local devices
> +       # Include rpmb, bootN, and partition nodes alongside the base dev=
ice.
> +       devices=3D$(compgen -G "/dev/mmcblk*" 2>/dev/null | grep -E '^/de=
v/mmcblk[0-9]+(rpmb|boot[0-9]+|p[0-9]+)?$')
> +
> +       local mmcbin
> +       mmcbin=3D$(type -P "${words[0]}") || return
> +
> +       # "mmc help" prints one "Usage for command\t<verb words...> <args=
...>"
> +       # line per command. Argument placeholders always start with '<', =
so
> +       # stripping from the first '<' onward leaves just the verb words.
> +       local verbs
> +       verbs=3D$("$mmcbin" help 2>/dev/null | sed -n 's/^Usage for comma=
nd[[:space:]]*//p' | sed 's/<.*//')
> +       [[ -z $verbs ]] && return
> +
> +       local -a typed=3D("${words[@]:1:cword-1}")
> +       local -A next_words=3D()
> +       local have_leaf=3D
> +
> +       local line i match
> +       while IFS=3D read -r line; do
> +               [[ -z $line ]] && continue
> +               local -a w
> +               read -ra w <<<"$line"
> +               [[ ${#w[@]} -lt ${#typed[@]} ]] && continue
> +
> +               match=3D1
> +               for ((i =3D 0; i < ${#typed[@]}; i++)); do
> +                       if [[ ${w[i]} !=3D "${typed[i]}" ]]; then
> +                               match=3D0
> +                               break
> +                       fi
> +               done
> +               [[ $match -eq 0 ]] && continue
> +
> +               if [[ ${#w[@]} -gt ${#typed[@]} ]]; then
> +                       next_words[${w[${#typed[@]}]}]=3D1
> +               else
> +                       have_leaf=3D1
> +               fi
> +       done <<<"$verbs"
> +
> +       if [[ ${#next_words[@]} -gt 0 ]]; then
> +               COMPREPLY=3D($(compgen -W "${!next_words[*]}" -- "$cur"))
> +       elif [[ -n $have_leaf ]]; then
> +               COMPREPLY=3D($(compgen -W "$devices" -- "$cur"))
> +       fi
> +}
> +
> +complete -F _mmc_complete mmc
> +complete -F _mmc_complete ./mmc
> diff --git a/docs/HOWTO.rst b/docs/HOWTO.rst
> index 0b486e4..3aba86f 100644
> --- a/docs/HOWTO.rst
> +++ b/docs/HOWTO.rst
> @@ -2,6 +2,12 @@
>
>  Running mmc-utils
>  -----------------
> +**Bash completion**
> +    Source ``completion/mmc`` to enable tab-completion for all subcomman=
ds and
> +    device paths. When installed via ``make install``, the file is place=
d in
> +    ``$(bashcompletiondir)`` (default: ``/usr/share/bash-completion/comp=
letions/mmc``)
> +    and loaded automatically by bash-completion.
> +
>  **Name**
>      mmc - a tool for configuring MMC storage devices
>  **Synopsis**
> --
> 2.53.0
