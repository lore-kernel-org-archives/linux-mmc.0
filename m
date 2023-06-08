Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9872C7EE29
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Jun 2023 17:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbjFHRoo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 8 Jun 2023 13:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234623AbjFHRoi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jun 2023 13:44:38 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C562D56;
        Thu,  8 Jun 2023 10:44:35 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-33dae9244a1so9588975ab.0;
        Thu, 08 Jun 2023 10:44:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686246275; x=1688838275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ovjq9ac+9Nx5rYGUxnFyT5CxYnERjUk28SaOLV692qI=;
        b=C0yIuq5bUoNga+E/bHgAE4jTFMY6CsDMVzayU9VsL88C378lFei+BltSOckss45J79
         6cpa/U8V7UnHRwuVLJScrg/GzJ2ZUBcBPXVDLGSkO+Hno1ha5yYc6quK2tzWHOwKWvqI
         FRp7y58Cr2MK+MABRRjRgu3Ij5i3E5vK6RQDBUvU5d/J8KBMM6nE21FxwZsEqm3tgoNF
         OxG4c52QV8FtMwBmcen6sYQXY3q+fPLiLZr4DUv9Hwm6Onef24XIaS+JmnRMpXkGX47/
         0Wor3k1bhgCCBiATLymrxGDRRcvIKu8LA2utGGzlhq2enYKAhwnCbak0YPLPGQ6czSAx
         U08g==
X-Gm-Message-State: AC+VfDwagy0zPsTQmeYXb5hYPSG2C8Dq8vSMJW74W6j0FwDUXLiPP1TI
        GIdsLDLQV+qID/emA6x1qg==
X-Google-Smtp-Source: ACHHUZ42fitQIzTfE7o2gQtXBs6JDleBPfB35sMO7jYvJt2sNMhYEga796RuBgdUqcd1XRBOWIFqGA==
X-Received: by 2002:a92:d445:0:b0:33d:cf66:7a0b with SMTP id r5-20020a92d445000000b0033dcf667a0bmr1794865ilm.13.1686246274891;
        Thu, 08 Jun 2023 10:44:34 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id q18-20020a920512000000b0033b2c178254sm546343ile.22.2023.06.08.10.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 10:44:34 -0700 (PDT)
Received: (nullmailer pid 3080900 invoked by uid 1000);
        Thu, 08 Jun 2023 17:44:32 -0000
Date:   Thu, 8 Jun 2023 11:44:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peng Fan <peng.fan@oss.nxp.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        haibo.chen@nxp.com, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, linux-imx@nxp.com, kernel@pengutronix.de,
        festevam@gmail.com, cniedermaier@dh-electronics.com,
        devicetree@vger.kernel.org, kernel@dh-electronics.com
Subject: Re: [PATCH v2 3/4] dt-bindings: mmc: fsl-imx-esdhc: remove property
 "fsl,wp-controller"
Message-ID: <20230608174432.GA3079839-robh@kernel.org>
References: <20230506074037.522961-1-haibo.chen@nxp.com>
 <20230506074037.522961-4-haibo.chen@nxp.com>
 <d0329227-b579-5557-b449-7961ec0a1463@linaro.org>
 <9ef80685-3ef7-ac59-05a6-0c46e0ecf57e@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ef80685-3ef7-ac59-05a6-0c46e0ecf57e@oss.nxp.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, May 23, 2023 at 10:03:08AM +0800, Peng Fan wrote:
> 
> 
> On 5/6/2023 6:59 PM, Krzysztof Kozlowski wrote:
> > Caution: This is an external email. Please take care when clicking links or opening attachments. When in doubt, report the message using the 'Report this email' button
> > 
> > 
> > On 06/05/2023 09:40, haibo.chen@nxp.com wrote:
> > > From: Haibo Chen <haibo.chen@nxp.com>
> > > 
> > > Driver do not use this property, so remove it here.
> > 
> > You still need to expand the commit msg and justify why this property is
> > being removed. "Driver" is vague, as it can be BSD driver which also
> > might use this binding. Instead describe why this property should be
> > removed, so we can understand also ABI implications.
> 
> The better approach would be mark it as deprecated.

Sure, but still need to say why.

Rob
