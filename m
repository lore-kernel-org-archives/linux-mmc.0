Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E56137AA78
	for <linux-mmc@vger.kernel.org>; Sat, 18 Jul 2026 13:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784380568; cv=pass; b=m4O0dgyrfmgV9q2kjDBEOzW2amaTZDTd9/iHhV8c/ufTVL29SRLX2cOkgL/8o+qQkbdWbUmmNu6IVtTs16In56tcvRZ82ta2poguDG6KGMwNC1pDjwZBX1v5D+mdeBRAM9ERNBe2IAs4jNERqV5Q20QkIoBXk2teiSxBokdiqoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784380568; c=relaxed/simple;
	bh=YWWKKP1NM6Xa0xF/SbN0PUecmshCSpxltTzIGLfBlEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H1yFkBtU5FYb0FFkJpRbvqqH4c6tTb9osYfX/dCM1GExYmkRiAUboxwTqgLL4YkfDiSIEm0CfFos8R0zpF0AbDCls/o0ANPVUMU8MSXPzT+TLM2tQsQE7bncHUbBbrCymMTfcfBbxH4RgAe9Uh9k9BKQImVLhBzek3NrOyAn52M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d3Yifl/s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=StQ3qtuH; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d3Yifl/s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="StQ3qtuH"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66IDDLhj569707
	for <linux-mmc@vger.kernel.org>; Sat, 18 Jul 2026 13:16:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s9LsI7Ks+5OkPcssA1dh56fgkFR9EggGyTbFx1yU1Gs=; b=d3Yifl/ssXQKGn3D
	DF+HGK4Iu8BpBWya3mu5Id9HxJPdHBvBYpMVHe9NoVde4B/Is8gKcFn2MaHMRoKj
	R0bDknMH/EDuNs/1BB2f0bGP5N3TW805FFJuvB16UvV4qhj/GnafRYo9y+UoTD6Y
	/ryL0ZwgJ/x3Hck8/IL5eCjqyrePpOB+xGNerA3Cz1eP6DBc97zST+Jyz5Cr5ldP
	9t+lea3FqT9rOS9S2+Mh50uHb8B3NI0AoOBeDx5SO3HqZttLttRdn4bA4DnMoHNj
	dBkrPP/rYZJoPGyv2S/N2w5RvhOVFI/1kTMjx+RKu9QyBqFV9C4iVLPsHyWyWIeW
	vIkcRw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2bvrsq6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Sat, 18 Jul 2026 13:16:03 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-90410c668adso172142506d6.1
        for <linux-mmc@vger.kernel.org>; Sat, 18 Jul 2026 06:16:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784380563; cv=none;
        d=google.com; s=arc-20260327;
        b=WyWC/VjTU7kn/kuWyeU7LcUjBKsNQq2epsqeuhsNZwtZiSFqEIgXVlwdfKQBEFa5Ij
         z6KPSPRCr7IMpvHPn9GhAXRNq4oxh1h198IFGBS5ZSxJYA2QijOLe0MF6XAMwHt8Bze3
         W4GTU4DIl1fLm1n9ErbAjA3wrzKntYpkjS8Rob0DdJNNuY8bGfvfNuNUDydcbBWyi00G
         lmA2t9BlHqdEvLeL9x/8JEs8GR6zPBcgJnWF+NxL+U2AFPnIGxliSj4ukJu/jP6nwmcy
         ae0ywQbmVLLElWTrqy67rA1gJI1T0+KeWqZ0Emaq17pc1WLiErMVdlPAnbSgsWu0GgmX
         eg0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s9LsI7Ks+5OkPcssA1dh56fgkFR9EggGyTbFx1yU1Gs=;
        fh=aFDf9P8NbTLPdUt6t/PavxBqrzgBQmi/ZsUmPFXNkME=;
        b=o9+y3B9SoGmFMENqqXxAye+r+Sp+DKElAnCnRCg43E8LfXmP0+uSyy0gSPL9m7+G3B
         lDboHfLMrsPAMj2pHLu9DMK+ED1D4iF8pUk0kGbjyRWDmzrBiDG5zlq+hOrzHAR+RGD7
         7jSocPmugvJtrTxOuXuy+VQVYYubsbr8ZJxaKjpNl1RI1rWD5BoVVOCPgGMqcmtSFAdd
         HJq0omKez5GGIU1fqu1ItBYFIIJMaeA0py1S1vcI0EBxpLHj8N+x+mAFVGDXTSxuGxIv
         OKQF6njMZ923tu4AvFbZVonGt9+BZ+GjRLBcVjoWO+4JVylJ5dePDrAw3zOyCtY2kuiM
         Ggmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784380563; x=1784985363; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s9LsI7Ks+5OkPcssA1dh56fgkFR9EggGyTbFx1yU1Gs=;
        b=StQ3qtuHpv1nuifEY3zPpij/Zm4TOf+WGz5i0+9EUGI0tn7ZtXRCYjO219CJutBou8
         wHd9Wz8B2YdonykiIl/D1ap9f00dyZd5TVK4jcdLkkf8sHeJvOtvnerh0BfCW7Lu+G0C
         YTUva9HDa9cYoJe6xGweJxgNZ2K3t7L5w9+xU/B13on+QaY+BA+khQU1tG2cU/DutKNT
         Mlev33oN+jc0wbieWrtGkbFeILRfBvssazBy7A4Grn/0PzhzhCTweUg4KjKm0oTSwcLB
         B0GOxDxS0Jatn1CdvEcYcAMzSdsa1zgD7eJjcNaahuJ4rBTx5SQHAw6YR5zANclL5paA
         2mWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784380563; x=1784985363;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s9LsI7Ks+5OkPcssA1dh56fgkFR9EggGyTbFx1yU1Gs=;
        b=HD9c4b75n5GdJ2e5z6dYffCws19ICW1VBoUqTxgCw8GZk1fQRVJu6pW49iKYKr82Uj
         VNDQ7p3KfXKx0e0Z33TCwn77JVgLPEgr3Hsk2Q+OXOD5n52yjYed9l+dHnQjLV4M+PO9
         OOdOgtX7K5GzEjcsYf1+lX32JTgSba4uujOGFHwKBioeqg4dx3h0IatecetBYGF5fT2J
         m2bUKCsTfS8FIZS4KXqb0KkXIhaMYVE9dMlUOZYjgSG18G6vFhdx/7E2b+90wGnXJteT
         gi7BhAjloPh+CFUvpvvICKBas2nao+aRdu0C8Uw7lpXVUWddty0FVnC+ng3Wz7YWubAn
         2/HQ==
X-Forwarded-Encrypted: i=1; AHgh+RrcP0x0G2l0cKCpG89RtRy0J8nm3k+A8ALldmVw85gKp1JjpuGUi8UPP70g8NsciRbvzDVNbshrTyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLdIxaJnux+ZYEDGjis7rC5FobdC/dY3FFpD6cvuCkWHRXMeJF
	VXGw+NkKwJ6afhQovKjg4nwtd8WAYxRr8TbC1v/Nhh73ABvd8UbyFoV8uPk4JJnIzIxQISwlWKp
	wsXJKCOVrpCWfqkGsL8nb6wZbmP/2HhB81U4HHlP99nS7cfqdT0QMnJYK4D0hwzmKcbAehew9br
	U9oNxfy/g7+zmd1Pj86IAv9ME13wo1v2IlVMrrzw==
X-Gm-Gg: AfdE7cmLz2Ehk6qtnEvVELrN67IL1fsFXninZkisXnrMq48uP5zYBnFqqAjk+APoAJg
	cAmBDD+JR2JtBCMKTUF7dHrGpAgfiEwOV+Yf9V0xzHaGbHR9QsbP+Heq8acy5fvwuSPCuL+PIQc
	tr8FK/bvUJcFX+V1jwoms/GmkSZrbbLW7tmcc6JObMzauO7vPwmKm3tikLYQ==
X-Received: by 2002:a05:6214:590e:b0:8ef:b23a:d741 with SMTP id 6a1803df08f44-9077834b1a4mr72688906d6.28.1784380562855;
        Sat, 18 Jul 2026 06:16:02 -0700 (PDT)
X-Received: by 2002:a05:6214:590e:b0:8ef:b23a:d741 with SMTP id
 6a1803df08f44-9077834b1a4mr72688496d6.28.1784380562406; Sat, 18 Jul 2026
 06:16:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716232641.2659710-1-jm@ti.com> <20260716232641.2659710-2-jm@ti.com>
 <CAPx+jO-a3+mv2msL+12Ag-xs33es2+Wxbr_uKRMY3rbN7eL-cw@mail.gmail.com> <305cf4be-2f45-49b9-b933-05ac41092685@ti.com>
In-Reply-To: <305cf4be-2f45-49b9-b933-05ac41092685@ti.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Sat, 18 Jul 2026 15:15:50 +0200
X-Gm-Features: AUfX_mxgm4OIA1ZLU83yHMzhZPvibIUr7WGe9Jot9LtHhbgQdK7G8sCeNXxkvAw
Message-ID: <CAPx+jO8F8UQi=ZSO0qRX1vtfximLWvuqmYkpbqm2+9xeB+qQRg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: Add post-power-off-delay-ms property
To: Judith Mendez <jm@ti.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: lTHVK1kn9fLTT_4I5Iu2ME7sUNAJ9Vvf
X-Authority-Analysis: v=2.4 cv=EcH4hvmC c=1 sm=1 tr=0 ts=6a5b7c94 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=sozttTNsAAAA:8 a=4ud4KnGQRwzs3n7kg5MA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDEzNSBTYWx0ZWRfXwIq/4Zz8WlPo
 V3agOvuYGqdR5envI+wC5YPagc7yiooR6+37EPAx5nP6r+OHnLq8WCnfR4fzR2uZTkUX5eKwq7J
 qQ2UuQ+mIQAmUZ8JhPqkyvk87bNXO9Epqot7lN7e76KHWaqBvUaPgJ5pkhYLwE0O+ZAw2BZBFQ4
 g+JhUmugtrMXXHMbJkqD36fi7lUiLgjHUFLKRn/KomGreBT4Svr0sw3s2CrbgUyXTvSaRe308ew
 W0e3laPfvLSO6sBdDeOWeThMNOaYDPG2mreZzJha8UhjIBAlZBy3rhHPZKMZwUHw8XgP38XmNKO
 2NOzn/+ApB6/VqUu2Rdr3bd80jQ4SLmCrBEcxiKtm0x75aZy40+wH9Iho6dukJHZTf3zMRIzk6y
 39chmzJUhtbQgvdT4nP9m+9OYpsmJ9I+Vy8I3yNzwNbSwxrLlDae0+oqEm37JIDy+DTR0fD3SfR
 nnNDkOpcrzEEcWT0YIg==
X-Proofpoint-ORIG-GUID: lTHVK1kn9fLTT_4I5Iu2ME7sUNAJ9Vvf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDEzNSBTYWx0ZWRfX+v8LV08QbLcL
 iv3tZk0hhk7yJnNQqI0ACu3ZZwnmpgpecMRp3mjAHOGau7MnAiw1KIqik+oZrqDR3dgAe7hrScb
 0jtN+k37oyCHEl6kleQlnNDlSnBegps=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607180135

On Fri, Jul 17, 2026 at 7:40=E2=80=AFPM Judith Mendez <jm@ti.com> wrote:
>
> Hi Ulf,
>
> On 7/17/26 5:21 AM, Ulf Hansson wrote:
> > On Fri, Jul 17, 2026 at 1:26=E2=80=AFAM Judith Mendez <jm@ti.com> wrote=
:
> >>
> >> Add post-power-off-delay-ms property to MMC controller common.
> >>
> >> This property shall be used to specify delay if needed after
> >> deasserting power during MMC power cycles.
> >
> > Please clarify with some additional information from the cover-letter,
> > like "specify custom delays after MMC power off to work around
> > hardware issues such as slow RC circuites on MMC VDD rails."
> >
> >>
> >> Signed-off-by: Judith Mendez <jm@ti.com>
> >> ---
> >>   .../devicetree/bindings/mmc/mmc-controller-common.yaml    | 8 ++++++=
++
> >>   1 file changed, 8 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-comm=
on.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
> >> index 3d7195e9461c3..3ff68d32a308f 100644
> >> --- a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
> >> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
> >> @@ -275,6 +275,14 @@ properties:
> >>         not available.
> >>       default: 10
> >>
> >> +  post-power-off-delay-ms:
> >
> > For mmc-pwrseq-simple we already have "power-off-delay-us", perhaps
> > better to re-use that name instead.
>
> Besides having the same dt property name as mmc-pwrseq-simple what is
> the benefit of switching to power-off-delay-us?

Using ms as the unit is limiting and completely unnecessary. What is
some HW is fine with 300 us, for example.

>
> All values will have to be in us instead of ms and thus will look a bit
> less clean in code. If it is just a naming  preference, I do prefer
> the current name in this version, please let me know if we can keep:
> post-power-off-delay-ms.

The code is a separate thing, this is the DT property for supporting
different HWs.

[...]

Kind regards
Uffe
